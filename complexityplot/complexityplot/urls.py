from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.conf.urls.defaults import *

handler404 = 'complexityplot.views.handler404'
handler500 = 'complexityplot.views.handler500'

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^null','complexityplot.views.nullview', name='null'),
    url(r'^create$', 'complexityplot.views.create', name='create'),
    url(r'^intro$','complexityplot.views.intro', name='intro'),
    url(r'^$','complexityplot.views.intro', name='intro'),
    url(r'^file-upload$', 'complexityplot.views.file_upload', name='file_upload'),
    url(r'^browse$', 'complexityplot.views.browse', name='browse'),
    url(r'^paper$','complexityplot.views.paper', name='paper'),
    url(r'^data_for_id$','complexityplot.views.data_for_id', name='data_for_id'),
    url(r'^data_for_session$','complexityplot.views.data_for_session', name='data_for_session'),
    url(r'^session_nuke$','complexityplot.views.session_nuke', name='session_nuke'),
    url(r'^session_createanother$','complexityplot.views.session_createanother', name='session_createanother'),
    url(r'^series-edit$','complexityplot.views.series_edit', name='series_edit'),
    url(r'^series-edit/(?P<did>.+)$','complexityplot.views.series_edit', name='series_edit'),
    url(r'^about$','complexityplot.views.about', name='about'),
    url(r'^print$','complexityplot.views.print_plot', name='print'),
    url(r'^contact$','complexityplot.views.contact', name='contact'),
    url(r'^contact_send$','complexityplot.views.contact_send', name='contact_send'),
    url(r'^privacy$','complexityplot.views.privacy', name='privacy'),
    url(r'^dataformat$','complexityplot.views.data_format', name='data_format'),
    url(r'^save$','complexityplot.views.save', name='save'),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
)
