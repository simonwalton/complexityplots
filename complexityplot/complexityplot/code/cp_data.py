
import uuid, os
from django.conf import settings
from estimators import nx_lin_estimator
import numpy
from scipy import stats
import json

data_dir = "datasets"
cp_classes = ["1","<i>ln</i> n","n","n <i>ln</i> n","n&sup2;","n&sup2;<i>ln</li> n","n&sup3","1.5&#8319;","2&#8319;","3&#8319;"];

def est_error_json():
    return json.dumps({"error":"""There was a problem using this data file as an input.
            Please ensure the file is formatted according to our data format guidelines."""})

def join_data_dir(data_filename):
    d = os.path.join(settings.STATICFILES_DIRS[0], data_dir)
    try :
        if not os.path.exists(d):
            os.makedirs(d)
    except:
        print "Problem creating directory " + str(d)

    return os.path.join(d,data_filename)

def write_input_file(filename,data):
    f = open(join_data_dir(filename))
    f.write(data)
    f.flush()

def write_output_file(filename,arr):
    numpy.savetxt(join_data_dir(filename), arr, delimiter=",", fmt='%.5f')

def run_estimator(ns,vs):
    default_win_size = 20

    nPoints  = ns.shape[0]
    windowSize = 0
    outputFileName = ""
    xvals=[] # estimated values for each window
    n_i=[] # Input size
    v_i=[] # measurements

    n_i,v_i=ns,vs#read_param_file(data_file)

    if windowSize==0:
        windowSize = default_win_size
    nWindows = int(numpy.ceil(nPoints/float(windowSize)))

    # Sum of square of error residuals
    Sr=numpy.array([0.0,0.0,0.0,0.0])

    out_est = numpy.zeros(nPoints)
    out_slope = numpy.zeros(nPoints)

    for idx in range(1,nPoints):
        startIndex=max(idx-windowSize+1,0)
        endIndex = idx
        estVal1,absErr1, errPC, order, estFunc = nx_lin_estimator(n_i[startIndex:endIndex+1],v_i[startIndex:endIndex+1],idx)
        out_est[idx] = estVal1
        X = ns[1:idx]
        Y = out_est[1:idx]
        if len(X) > 1:
            out_slope[idx] = stats.linregress(numpy.log(X),numpy.log(Y))[0]

    return ns[1:], out_slope

