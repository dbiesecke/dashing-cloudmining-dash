FROM ubuntu:14.04

MAINTAINER dbiesecke <dbiesecke@nothing.com>

ADD ./run.sh /run.sh

ADD ./ /dashing
RUN test -f /dashing/Gemfile.lock && rm /dashing/Gemfile.lock
RUN apt-get update
RUN apt-get install libxml2 libxml2-dev ruby2.0 ruby-nokogiri -f -y
RUN apt-get build-dep ruby-nokogiri -y -f 
RUN gem install bundle
RUN gem install dashing

RUN cd /dashing && bundle
RUN ln -s /dashing/dashboards /dashboards && \
    ln -s /dashing/jobs /jobs && \
    ln -s /dashing/public /public && \
    ln -s /dashing/widgets /widgets
RUN mkdir /dashing/config && \
    mv /dashing/config.ru /dashing/config/config.ru && \
    ln -s /dashing/config/config.ru /dashing/config.ru && \
    ln -s /dashing/config /config
ADD run.sh /


EXPOSE 3030
WORKDIR /dashing

CMD ["/run.sh"]

