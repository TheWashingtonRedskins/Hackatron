FROM phusion/baseimage:0.9.18
#RUN apt-get update && apt-get install build-essential -y && apt-get clean
RUN curl https://install.meteor.com/ | sh

# Little hack to try to cache some of the download steps
WORKDIR /build/
ENV CACHED_BUILD="meteor add iron:router"

ADD .meteor/ /build/.meteor/
RUN $CACHED_BUILD

ADD package.json /build/
RUN meteor npm install

ADD . /build/

ENV PORT=80
CMD meteor run --production --port 80
EXPOSE 80
