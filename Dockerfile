FROM ruby:2.3-slim

ENV BUNDLER_VERSION=1.14.6

RUN apt-get update -qq && apt-get install -y build-essential libmariadb-client-lgpl-dev file \
  libpq-dev nodejs git curl libfontconfig && \
  gem install bundler --version $BUNDLER_VERSION && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /app

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install --jobs 4 --retry 3 --without development test

COPY . /app

# Set Rails to run in production (ideally should be taken directly from external source e.g. Heroku config)
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Secret key to precompile the assets (ideally should be taken directly from external source e.g Heroku config)
ENV SECRET_KEY_BASE=e8614a9b9d5cacbe0efed4e83ae286916f2742116bed21dc9bb05d333572d2e46fa9faf4f7639fd73d33226b8d808b22bffb141733d20495eeba4b3f156fa71a

# Precompile assetsq
RUN bundle exec rake assets:precompile

# Start puma
CMD bundle exec puma -C config/puma.rb
