from django.http import HttpResponse
from django.shortcuts import render, redirect, render_to_response, RequestContext
from django.conf import settings
import os
from code import cp_data, cp_session
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from complexityplot.models import Dataset, Plot
from django.views.decorators.csrf import csrf_protect, csrf_exempt
import json
from django.core.mail import send_mail
from django.db.models import Count

vis_per_page = 8
static_url = settings.STATIC_URL

cookieid_agreedtoterms = "userchoice_agreedtoterms"

def nullview(request):
    return render(request, "complexityplot/404.html")

def handler404(request):
    return render(request, "complexityplot/404.html")

def handler500(request):
    return render(request, "complexityplot/500.html")

def create(request):
    return render(request, "complexityplot/index.html")

def about(request):
    return render(request, "complexityplot/about.html")

def intro(request):
    return render(request, "complexityplot/introduction.html")

def data_format(request):
    return render(request, "complexityplot/dataformat.html")

def browse(request):
    allplots = Plot.objects.filter(public=True).annotate(num_ds=Count('datasets')).filter(num_ds__gt=0)
    paginator = Paginator(allplots,vis_per_page)

    page = request.GET.get('page')
    try:
        p = paginator.page(page)
    except PageNotAnInteger:
        p = paginator.page(1)
    except Emptypage:
        p = paginator.page(paginator.num_pages)

    return render_to_response("complexityplot/browse.html", { "plots": p})

def contact(request):
    return render_to_response("complexityplot/contact.html")

def privacy(request):
    return render_to_response("complexityplot/privacy.html")

def print_plot(request):
    return render(request, "complexityplot/print.html")

@csrf_protect
def contact_send(request):
    j = json.loads(request.body)
    email_from = j['email']
    email_subject = "CP Feedback: " + j['subject']
    email_name = j['name']
    email_body = j['comments']

    try:
        send_mail(email_subject, email_body, email_from,
            [item[1] for item in settings.ADMINS], fail_silently=False)
    except:
        print "Whoop - problem sending mail"
        return HttpResponse(json.dumps({'error_message': "There was a problem sending the email. Please ensure all fields are filled in correctly. Please contact " +
                                  settings.ADMINS[0][1] + " if the problem continues."}), content_type="application/json")
    else:
        return HttpResponse(json.dumps({'success_message': 'Your request was sent successfully!'}), content_type="application/json")

def data_for_id(request):
    i = request.GET.get('id')
    p = Plot.objects.get(id=i)
    return p.json_response()

def data_for_session(request):
    p = cp_session.ensure_plot(request)
    return p.json_response()

def session_nuke(request):
    p = cp_session.nuke(request)
    return p.json_response()

def session_createanother(request):
    p = cp_session.createanother(request)
    return p.json_response()

def save(request):
    plot = cp_session.ensure_plot(request)
    cp_session.save_plot(request)
    plot.save()
    print "Saved plot " + str(plot)
    return plot.json_response()

def paper(request):
    static_file_path = static_url + "/complexityplot-eurovis2013.pdf"
    return redirect(static_file_path)

from urlparse import urlparse, parse_qs

@csrf_exempt
#@csrf_protect
def series_edit(request, did = ''):
    # horrendously hacky, but works for angular
    qry = parse_qs(urlparse(request.META['HTTP_REFERER']).query)
    if 'id' in qry:
        # not session-based
        plot_id = int(qry['id'][0])
        p = Plot.objects.get(id=int(plot_id))
        return HttpResponse(p.datasets_json(), content_type="application/json")
    else:
        # session-based
        print "Series_edit %s" % str(did)
        p = cp_session.ensure_plot(request)

        if request.method == 'GET':
            if len(did) == 0:
                j = p.datasets_json()
                return HttpResponse(j, content_type="application/json")
            elif not did == 'undefined':
                d = p.dataset_for_guid(did)
                j = d.json()
                return HttpResponse(j, content_type="application/json")
            else:
                return HttpResponse(Dataset().json(), content_type="application/json")
        elif request.method == 'POST':
            j = json.loads(request.raw_post_data)
            if 'id' in j:
                print "SAVING"
                d = p.dataset_for_guid(j['id'])
                d.name = j['name']
                d.set_csv_text(j['csv'])
                d.save()
                return HttpResponse()
            else:
                print "NEW"
                print j
                d = Dataset(name=j['name'])
                d.set_csv_text(j['csv'])
                d.save()
                p.datasets.add(d)
                p.save()
                return HttpResponse(d.json(), content_type="application/json")
        elif request.method == 'DELETE':
            print "**** DELETE ID %s" % str(did)
            try:
                d = p.dataset_for_guid(did)
                d.delete()
            except:
                print "Problem deleting, yo"

            return HttpResponse()#p.datasets_json(),content_type="application/json")


def file_upload(request):
    # create a new plot if necessary and attach to session
    p = cp_session.ensure_plot(request)
    # create a new dataset to house upload
    d = Dataset(name=str(request.FILES['files[]']))
    # write uploaded file to disk
    d.set_csv_from_upload(request.FILES['files[]'])
    d.save()

    # attach data series to plot
    p.datasets.add(d)
    p.save()

    return HttpResponse(json.dumps(""),content_type="application/json")

def get_session_files(request):
    if 'plot' in request.session:
        p = request.session['plot']
        return HttpResponse(p.input_list_str())
    else:
        return HttpResponse("[];")
