\
'''
Created on Oct 30, 2012

@author: jeyan
'''

# Sliding window
# Log-based estimator
# polynomial-based regression
# return the function which is estimated in a different text file
# do the trial and error polynomial fitting  start with x = 2,3 ...... k
# error for each of estimator
# check the VBA scripts for estimations etc


import numpy as np
import sys
import datetime as dt
import warnings


######################################################## Exponential Estimator - useful for x^n type


# Estimator for exponential axis type
# based on power regression, y=Ae^(Bn)
# we vary n and we are interested in A and B
# ln y = B n + ln A
# Use the linear regression and then
# work out the gradient B, and intercept ln A
# B = gradient and A = exp (intercept)
# see; http://mathworld.wolfram.com/LeastSquaresFittingExponential.html
def xn_exp_estimator(ni,vi,w):
    vi_w = vi
    ni_w = ni
    ln_vi_w = np.log(vi_w)
    # perform linear regression
    A = np.array([ ni_w, np.ones(len(ni_w))])
    # linearly generated sequence
    solution = np.linalg.lstsq(A.T,ln_vi_w)[0] # obtaining the parameters
    gradient = solution[0]
    intercept= solution[1]
    B = gradient
    A = np.exp(intercept)

    estVal = A*np.exp(B*ni_w[-1])
    absErrVal = np.abs(estVal-vi_w[-1])
    errPC = (absErrVal/vi_w[-1])*100.0
    estFunc = str(A) + " * exp(" + str(B) + "n)"
    order = B
    return estVal,absErrVal, errPC, order, estFunc





######################################################## X^N type axis - (1^n, 2^n, 3^n ...)


# Estimator for x^n type axis
# based on power regression, y=px^n,
# we vary n and we are interested in p and x
# ln y = n ln x. x + ln p
# Use the linear regression and then
# work out the gradient ln x, and intercept ln p
# x = exp (gradient) and p = exp (intercept)
# see; http://glowingpython.blogspot.co.uk/2012/03/linear-regression-with-numpy.html
def xn_lin_estimator(ni,vi,w):
    vi_w = vi
    ni_w = ni
    ln_vi_w = np.log(vi_w)
    # perform linear regression
    A = np.array([ ni_w, np.ones(len(ni_w))])
    # linearly generated sequence
    solution = np.linalg.lstsq(A.T,ln_vi_w)[0] # obtaining the parameters
    gradient = solution[0]
    intercept= solution[1]
    x = np.exp(gradient)
    p = np.exp(intercept)

    estVal = p*np.power(x,ni_w[-1])
    absErrVal = np.abs(estVal-vi_w[-1])
    errPC = (absErrVal/vi_w[-1])*100.0
    estFunc = str(p) + " * " + str(x) + "^n"
    order = x
    return estVal,absErrVal, errPC, order, estFunc







######################################################## N^X type axis - (n^1, n^2, n^3 ...)



# Estimator for n^x type axis
# based on power regression, y=p.n^x,
# we vary n and we are intersted on p and x
# ln y =  x.ln n + ln p
# Use the linear regression and then
# work out gradient x and intercept ln p
# x = gradient, p = exp(intercept)
# for axis type n^k
def nx_lin_estimator(ni,vi,idx = 0):
    vi_w = vi
    ni_w = ni
    ln_vi_w = np.log(vi_w)
    ln_ni_w = np.log(ni_w)
    # perform linear regression
    A = np.array([ ln_ni_w, np.ones(len(ln_ni_w))])
    # linearly generated sequence
    solution = np.linalg.lstsq(A.T,ln_vi_w)[0] # obtaining the parameters
    gradient = solution[0]
    intercept = solution[1]
    x = gradient
    p = np.exp(intercept)

    estVal = p*np.power(ni_w[-1],x)
    absErrVal = np.abs(estVal-vi_w[-1])
    errPC = (absErrVal/vi_w[-1])*100.0
    estFunc = str(p) + " * n^" + str(x)
    order = x
    return estVal,absErrVal, errPC, order, estFunc



######################################################## Polynomial Estimator - - useful for n^x type

# Polynomial estimator  for n^x type axis
# y = an^x + bn^(x-1) etc and we are interested
# in the highest order and the coefficients a, b etc
# Since the order has to be an important parameter
# for Polynomial estimator, orders are exhaustively searched from
# 1 through 10
# and we pick the order which minimises the standard deviatino erorr
# as discussed http://autarkaw.wordpress.com/2008/07/05/finding-the-optimum-polynomial-order-to-use-for-regression/

def nx_poly_estimator(ni,vi,w):
    vi_w = vi
    ni_w = ni
    min_Sr = float(np.Inf)
    for orderN in range(1,11):
        z = np.polyfit(ni_w, vi_w, orderN)
        # calculate the Sr
        err2 = np.power( (np.polyval(z, ni_w)-vi_w),2)
        Sr = np.sum(err2)
        if (Sr < min_Sr):
            min_Sr = Sr
            order_best = orderN

    # recalculate the best we found so far
    z = np.polyfit(ni, vi, order_best)

    estVal = np.polyval(z, ni_w[-1])
    absErrVal = np.abs(estVal-vi_w[-1])
    errPC = (absErrVal/vi_w[-1])*100.0
    estFunc = "Poly:" + str(z)
    order = order_best
    return estVal,absErrVal, errPC, order, estFunc




######################################################## Other routines

# Reads the supplied data file
def read_param_file(file_name):
    ni, vi=np.loadtxt(file_name, skiprows=1, delimiter=',', usecols=(0,1),unpack=True)
    w=len(ni)
    return ni,vi,w





######################################################## Main routine
if __name__ == '__main__':

    default_win_size = 20
    warnings.simplefilter('ignore', np.RankWarning)
    if len(sys.argv) < 2:
        print "Usage: estimator <input_file> "
        print "       the outputs are dumped to a text file whose name is auto-generated"
        print "       All of the following estimators will be run       : 0 - nx_lin_estimator"
        print "                                                         1 - nx_power_estimator"
        print "                                                         2 - nx_mean_log_estimator"
        print "                                                         3 - xn_lin_estimator1"
        print "       Usually  windows_size of 20 is suggested, and it is prefixed."
        sys.exit()



    nPoints  = 0
    windowSize = 0
    outputFileName = ""
    estimator_type = 0
    fileNameSecondPart = dt.datetime.now().strftime("%d%m%Y_%H%M")
    fileNameFirstPart = ""
    xvals_nx_1=[] # estimated values estimator 1
    xvals_nx_2=[] # estimated values estimator 2
    xvals_nx_3=[] # estimated values estimator 3

    xvals_xn_1=[] # estimated values estimator 1 for axis x^n

    xvals=[] # estimated values for each window




    n_i=[] # Input size
    v_i=[] # measurements



    if len(sys.argv) > 1:
        data_file = sys.argv[1]

    if len(sys.argv) > 2:
        windowSize = int(sys.argv[2])

    n_i,v_i,nPoints=read_param_file(data_file)

    if windowSize==0:
        windowSize = default_win_size

    nWindows = int(np.ceil(nPoints/float(windowSize)))
    print ">>Window Size      : ",windowSize
    print ">>Number of windows: ",nWindows




    # Sum of square of error residuals
    Sr=np.array([0.0,0.0,0.0,0.0])


    # Perform Full Call to each method to build the table we need
    outStr = str("N") + "\t"  + str("V") + "\t" + str("E1") + "\t" + str("E2") + "\t" + str("E3") +  "\t" + str("E4")
    print outStr
    outStr = str(n_i[0]) + "\t" + str(v_i[0]) + "\t" + str(v_i[0]) + "\t" + str(v_i[0]) + "\t" + str(v_i[0]) +  "\t" + str(v_i[0])
    print outStr
    for idx in range(1,nPoints):
        startIndex=max(idx-windowSize+1,0)
        endIndex = idx
        estVal1,absErr1, errPC, order, estFunc = nx_lin_estimator(n_i[startIndex:endIndex+1],v_i[startIndex:endIndex+1],idx)
        estVal2,absErr2, errPC, order, estFunc = nx_poly_estimator(n_i[startIndex:endIndex+1],v_i[startIndex:endIndex+1],idx)
        estVal3,absErr3, errPC, order, estFunc = xn_lin_estimator(n_i[startIndex:endIndex+1],v_i[startIndex:endIndex+1],idx)
        estVal4,absErr4, errPC, order, estFunc = xn_exp_estimator(n_i[startIndex:endIndex+1],v_i[startIndex:endIndex+1],idx)
        if (Sr[0]<sys.maxint/2):
            Sr[0]=Sr[0] + np.power(absErr1,2)
        if (Sr[0]<sys.maxint/2):
            Sr[1]=Sr[1] + np.power(absErr2,2)
        if (Sr[0]<sys.maxint/2):
            Sr[2]=Sr[2] + np.power(absErr3,2)
        if (Sr[0]<sys.maxint/2):
            Sr[3]=Sr[3] + np.power(absErr4,2)
        outStr = str(n_i[idx]) + "\t" + str(v_i[idx]) + "\t" + str(estVal1) + "\t" + str(estVal2) + "\t" + str(estVal3) +  "\t" + str(estVal4)
        print outStr
    outStr = str("") + "\t" + str("") + "\t" + str(Sr[0]) + "\t" + str(Sr[1]) + "\t" + str(Sr[2]) +  "\t" + str(Sr[3])
    print outStr


