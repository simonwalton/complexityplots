from django.db import models
from django.http import HttpResponse
import json
from code import cp_data
import numpy
import os
from django.core.files import File
import uuid

DatasetStatus = {'NE':['Unestimated','label label-warning'],
				 'E':['Valid','label label-success'],
				 'PE':['Invalid','label label-important']}


class Dataset(models.Model):
	guid =	models.CharField(max_length=512)		# guid of the series (to locate file)
	name = models.CharField(max_length=128)								# the name of the series
	status = models.CharField(max_length=4,default="NE")	# status (ok, failure, etc)

	def __init__(self, *args, **kwargs):
		super(Dataset,self).__init__(*args,**kwargs)
		if not self.guid:
			self.guid = str(uuid.uuid1())
		if not self.name:
			self.name = "Untitled series"

	def set_csv_text(self, text):
		path = cp_data.join_data_dir(self.orig_filename())
		f = file(path,'w')
		f.write(text)
		f.flush()
		self.estimate()

	def set_csv_from_upload(self,data):
		static_file_path = cp_data.join_data_dir(self.orig_filename())
		with open(static_file_path, 'wb+') as destination:
			for chunk in data.chunks():
				destination.write(chunk)
		self.estimate()

	def csv_text(self):
		path = cp_data.join_data_dir(self.orig_filename())
		try:
			f = open(path)
		except:
			f = open(path,'w')
			tf = File(f)
			f = open(path)

		return f.read()

	# filename of original data
	def orig_filename(self):
		return self.guid + "_orig"

	# filename of estimated data (may not be available!)
	def est_filename(self):
		return self.guid + "_est"

	def json(self):
		return json.dumps({u'_id':self.guid,
			u'name':self.name,
			u'id':self.guid,
			u'status_span_class':DatasetStatus[self.status][1],
			u'seriesId':self.guid,
			u'csv':self.csv_text(),
			u'status':DatasetStatus[self.status][0]})

	def estimate(self):
		try:
			# load in as CSV
			data = numpy.genfromtxt(cp_data.join_data_dir(self.orig_filename()), delimiter = ',', skip_header=1)
			# run estimator
			ns, est = cp_data.run_estimator(data[:,0],data[:,1])
			# write the zipped results to output file
			cp_data.write_output_file(self.est_filename(),zip(ns,est))

			self.status = "E"
		except Exception, e:
			print e
			self.status = "PE"

class Plot(models.Model):
	name = models.CharField(default="My complexity plot", max_length=256)	  # name of plot (optional)
	description = models.TextField(default="Write a brief description of your plot.")
	datasets = models.ManyToManyField(Dataset)	# datasets belonging to plot
	public = models.BooleanField(default=True)
	show_baseline = models.BooleanField(default=True)
	auto_zoom  = models.BooleanField(default=False)
	use_sci_notation = models.BooleanField(default=True)
	line_width = models.IntegerField(default=1)
	colour_scheme = models.IntegerField(default=0)
	enabled_classes = models.TextField(default="[" + ",".join([str(i) for i in range(len(cp_data.cp_classes))]) + "]")

	def ensure_csvs_exist(self):
		for d in self.datasets.objects():
			d.ensure_csv()

	def __unicode__(self):
		return self.name + " (" + str(self.datasets.count()) + ") datasets. Public=" + str(self.public)

	def input_list_str(self):
		return "[" + ",".join(["['" + i[0] + "','" + i[1] + "','" + i[2] + "']"
			for i in
			zip([d.guid for d in self.datasets.all()],					# 0: id
				[d.est_filename() for d in self.datasets.all()],
				[d.name for d in self.datasets.all()]
			)]) + "];"

	def dataset_for_guid(self,g):
		return self.datasets.get(guid=g)

	def json(self):
		response = dict()
		response['input_files'] = self.input_list_str()
		response['title'] = self.name
		response['description'] = self.description
		response['use_sci_notation'] = self.use_sci_notation
		response['auto_zoom'] = self.auto_zoom
		response['line_width'] = self.line_width
		response['colour_scheme'] = self.colour_scheme
		response['show_baseline'] = self.show_baseline
		response['public'] = self.public
		response['enabled_classes'] = self.enabled_classes
		return json.dumps(response)

	def datasets_json(self):
		return json.dumps([ json.loads(x.json()) for x in self.datasets.all() ])

	def json_response(self):
		return HttpResponse(self.json(), content_type="application/json")

	def num_series(self):
		return self.datasets.count()

	def is_public(self):
		return self.public
