FROM ruby:2.7.7-buster

ARG APP_ROOT
ARG UID=1000
ARG GID=1000
ARG LOGIN_USER=app

ENV TERM "xterm-256color"

WORKDIR $APP_ROOT

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get update && \
    apt-get install -y nodejs \
    sqlite3 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -r --gid $GID $LOGIN_USER && \
    useradd -m -r --uid $UID --gid $GID $LOGIN_USER

COPY --chown=$LOGIN_USER:$LOGIN_USER Gemfile $APP_ROOT/
COPY --chown=$LOGIN_USER:$LOGIN_USER Gemfile.lock $APP_ROOT/

# [Note]allow rails to write /var/log/*.log
RUN chown -R $LOGIN_USER:$LOGIN_USER /var

RUN mkdir -p $APP_ROOT $BUNDLE_APP_CONFIG && \
    chown -R $LOGIN_USER:$LOGIN_USER $APP_ROOT && \
    chown -R $LOGIN_USER:$LOGIN_USER $BUNDLE_APP_CONFIG

USER ${LOGIN_USER}

RUN echo 'gem: --no-document' >> ~/.gemrc && \
    bundle config --global build.nokogiri --use-system-libraries && \
    bundle config --global jobs 4 && \
    bundle config set without development test && \
    bundle install -j4 --full-index && \
    rm -rf ~/.gem

COPY --chown=$LOGIN_USER:$LOGIN_USER . $APP_ROOT/
EXPOSE  3000

# CMD ["rails", "s", "-b", "0.0.0.0"]
ENTRYPOINT ["init/init.sh"]
