FROM ruby:2.7.2
# Note that prior .ruby-version was 2.4.1
WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
# throw errors if Gemfile has been modified since Gemfile.lock (use 'bundle config unset frozen` to unfreeze)
# RUN bundle config --global frozen 1

RUN gem install bundler ; # && bundle update

COPY . .
RUN bundle install ; # --binstubs

# Launch config.ru via rackup
EXPOSE 9292
CMD ["bundle", "exec", "rackup", "-o", "0.0.0.0"]
