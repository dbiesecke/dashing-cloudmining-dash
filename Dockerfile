FROM frvi/ruby

MAINTAINER dbiesecke <dbiesecke@nothing.com>

ADD ./run.sh /run.sh

ADD ./ /dashing
RUN apt-get update
RUN apt-get install build-essential libxml2-dev libxslt1-dev nodejs sqlite3 libsqlite3-dev libc-ares2 ruby-json ruby-multi-json ruby-oj ruby-yajl -y -f
RUN gem install --no-rdoc --no-ri bundle dashing execjs rails

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

