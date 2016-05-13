FROM ubuntu:14.04
MAINTAINER J. Christopher Bare
RUN apt-get update && apt-get install -y \
        octave \
        octave-signal
COPY *.m /
ENTRYPOINT ["octave"]
WORKDIR /
