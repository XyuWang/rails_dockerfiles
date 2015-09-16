FROM ruby:2.2.3

RUN apt-get update && apt-get install -y \
  imagemagick \
  curl \
  cron \
  && rm -rf /var/lib/apt/lists/*

# install nodejs, nodejs in apt source are too old
WORKDIR /tmp/
RUN curl -o nodejs.tar.gz https://nodejs.org/dist/v0.12.7/node-v0.12.7-linux-x64.tar.gz \
  && tar xf nodejs.tar.gz -C /usr/local/share \
  && ln -s /usr/local/share/node-v0.12.7-linux-x64/bin/* /usr/local/bin \
  && rm nodejs.tar.gz \
  && npm install bower -g

ADD ./Gemfile /tmp/Gemfile
ADD ./Gemfile.lock /tmp/Gemfile.lock
RUN bundle install

ADD ./package.json /tmp/package.json
ADD ./bower.json /tmp/bower.json
RUN npm install -g \
  && bower install -g --allow-root

RUN rm -rf /tmp
