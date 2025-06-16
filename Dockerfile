FROM ruby:3.4.4-alpine3.22

WORKDIR /app

COPY app/ .

CMD ["sh"]
