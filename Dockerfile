FROM ruby:3.4.4-alpine3.22

WORKDIR /app

COPY app/Gemfile app/Gemfile.lock ./
RUN bundle config set without 'development test' && \
  bundle install

COPY app/ .

CMD ["sh"]
