FROM awsam/railgun-base

WORKDIR /code/

ADD ./package.json /code/package.json
RUN npm install -g

ADD ./Gemfile /code/Gemfile
ADD ./Gemfile.lock /code/Gemfile.lock
RUN bundle install

ADD ./bower.json /code/bower.json
RUN bower install -g --allow-root

# set up deploy key
ADD ./id_rsa /root/.ssh/id_rsa
ADD ./id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 700 /root/.ssh/id_rsa
RUN echo "Host example.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

ENV DEPLOYED_VERSION=no

RUN git clone -b master git@xxx.git --depth=50 /tmp/Railgun \
    && cd /tmp/Railgun \
    && if [ "$DEPLOYED_VERSION" != "no" ]; then git checkout $DEPLOYED_VERSION ; fi \
    && cp -rf /tmp/Railgun/code / \
    && rm -rf /tmp/Railgun

WORKDIR /code
RUN bundle install
RUN npm install
RUN rake bower:install['--allow-root']
RUN RAILS_ENV=production bundle exec rake assets:precompile

ADD ./cron.sh /cron.sh

EXPOSE 8080
