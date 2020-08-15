FROM ruby:2.6.5-stretch

ARG APP_ROOT
ENV TERM "xterm-256color"

WORKDIR $APP_ROOT

RUN apt-get update && \
    apt-get install -y nodejs \
                       mariadb-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

#RUN echo '0' > tmp/pids/server.pid

COPY . $APP_ROOT
RUN chmod 755 ${APP_ROOT}/init/init.sh
EXPOSE  3000

#CMD ["rails", "s", "-b", "0.0.0.0"]
ENTRYPOINT ["init/init.sh"]
