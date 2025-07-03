FROM ruby:3.3.3-slim-bullseye

RUN apt-get update -qq && apt-get install -y build-essential nodejs git openssh-client && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN mkdir -p /app/tmp

COPY .ruby-version Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ARG RAILS_ENV
ENV RAILS_ENV=$RAILS_ENV

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
