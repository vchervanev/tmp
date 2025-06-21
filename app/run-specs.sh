
# TODO: improve with multistage build
bundle config unset without && \
  apk add build-base && \
  bundle install && \
  bundle exec rspec -fd
