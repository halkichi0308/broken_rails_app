FROM ruby:2.7.7-buster

ARG APP_ROOT
ENV TERM "xterm-256color"

WORKDIR $APP_ROOT

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - 
RUN apt-get update && \
    apt-get install -y nodejs \
    sqlite3 \
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
    bundle install -j4 --full-index && \
    rm -rf ~/.gem


COPY . $APP_ROOT
RUN chmod 755 ${APP_ROOT}/init/init.sh
EXPOSE  3000

#CMD ["rails", "s", "-b", "0.0.0.0"]
ENTRYPOINT ["init/init.sh"]
