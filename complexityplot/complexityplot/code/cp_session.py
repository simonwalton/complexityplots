
import uuid, os
from django.conf import settings
from complexityplot.models import Dataset, Plot
from django.http import HttpResponse
from django.shortcuts import render, redirect, render_to_response, RequestContext
from django.conf import settings
import json

cookieid_datascope = "userchoice_datascope"

def ensure_plot(request):
  # create a new plot if necessary and attach to session
    if 'plot' not in request.session or request.session['plot'] == None:
        p = Plot()
        print "Creating new plot for user session..."
        request.session['plot'] = p
        request.session.set_expiry(0)
    else:
        print "Found existing session with plot " + str(request.session['plot'])

    p = request.session['plot']
    p.save()
    request.session['plot'] = p

    return p
"""
def test_plot(request):
    p = ensure_plot(request)
    if p.datasets.count() == 0:
        d = Dataset(guid='rg4g45g',name='A dataset')
        p.datasets.clear()
        p.save()
        d.save()
        p.datasets.add(d)
        d = Dataset(guid='dddhhdh',name='Another dataset')
        d.save()
        p.datasets.add(d)
        p.save()
    return p
"""

def nuke(request):
    sp = request.session['plot']
    sp.delete()
    request.session['plot'] = None
    sp = ensure_plot(request)
    return sp

def createanother(request):
    request.session['plot'] = None
    sp = ensure_plot(request)
    return sp

def post_list_to_str(request, name):
    lst = request.POST.getlist(name+"[]")
    print lst
    return "[" + ",".join(lst) + "]"

def save_plot(request):
    sp = request.session['plot']
    title = request.POST.get("title")

    # extract the series provided from the client chart
    if sp.datasets.count() > 0:
        i = 0
        found = True
        inputs = []
        while found:
            lst = request.POST.getlist("input_files[%i][]" % i)
            found = len(lst) > 0
            if found:
                inputs.append(lst)
            i += 1

        for dataset in sp.datasets.all():
            # check existing plot datasets for removal of a series (addition via file_upload only)
            # has the user removed a dataset on the client side?
            if dataset.guid not in zip(*inputs)[0]:
                # yes; remove from the plot object
                print "Removing a plot"
                sp.datasets.remove(dataset)

            # check whether this is a new blank dataset
            if dataset.guid is None or len(dataset.guid) == 0:
                dataset.guid = uuid.uuid1()

    print request.POST

    sp.name = title
    sp.description = request.POST.get('description')
    sp.show_baseline = request.POST.get('show_baseline') == 'true'
    sp.show_all_classes = request.POST.get('show_all_classes') == 'true'
    sp.use_sci_notation = request.POST.get('use_sci_notation') == 'true'
    sp.line_width = int(request.POST.get('line_width'))
    sp.colour_scheme = int(request.POST.get('colour_scheme'))
    sp.public = request.POST.get('public') == 'true'
    sp.enabled_classes = post_list_to_str(request,'enabled_classes')
    sp.save()

    print sp

    request.session['plot'] = sp

