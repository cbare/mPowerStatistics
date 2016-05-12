# Note we specify a specific version of rocker/rstudio which we know to use v 3.2 of R
# This is temporary, until synapseClient is released for R 3.3.
FROM rocker/rstudio@sha256:d700e386bd73e3581b12309e338d88e035c145cce6b8d2edfbbfd420d26a5b7b

# Note:  The following is needed if starting from r-base, but doesn't work 
# because r-base is based on the 'testing' versions of Debian libraries, 
# and libcurl does not seem to be available
# RUN apt-get install libcurl4-openssl-dev
# Also doesn't seem to work to override the testing default
# RUN apt-get install -o APT::Default-Release=stable libcurl4-openssl-dev

# install octave to compute medianF0 voice feature
RUN apt-get update && apt-get install -y \
        octave \
        octave-signal \
        libav-tools

RUN Rscript -e "source('http://depot.sagebase.org/CRAN.R'); pkgInstall('synapseClient')"
RUN Rscript -e "install.packages(c('devtools','testthat','RJSONIO','fractal','pracma','changepoint','lomb','uuid','crayon','RCurl'), repo='http://cran.mirrors.hoobly.com')"

COPY . /mPowerStatistics

# Note:  Omitting '--no-manual' below results in "Error in texi2dvi(...):  pdflatex is not available"
RUN cd /mPowerStatistics && R CMD check  --no-manual .
RUN cd /mPowerStatistics && R CMD INSTALL .
