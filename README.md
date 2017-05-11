![Logo](http://ovii.oerc.ox.ac.uk/cpstatic/images/teaser.png)

# Complexity Plots

This is web-based implementation of the technique found in our Eurovis 2013 paper, Complexity Plots. The paper can be found  [here (PDF)](http://ovii.oerc.ox.ac.uk/cpstatic//complexityplot-eurovis2013.pdf).

A full working demo can be found at the [Complexity Plots website](http://ovii.oerc.ox.ac.uk/cp). 

## Building

The web application is backed by a Django 1.6 application which provides the complexity estimation code and handles user submission of algorithm timings. 

To install the Python library requirements, run:

    pip install -r requirements.txt

or, if you want to use Postgres as the dabase backend:

    pip install -r requirements-postgres.txt

To initialise the database (SQLite is used by default), run:
    
    python manage.py syncdb


## Running

Though the client and server can be run independently (and they are in fact run as such our ovii server), you can run them both on your local machine simply with:

    python manage.py runserver
  
Which will run django's built-in HTTP server. 
