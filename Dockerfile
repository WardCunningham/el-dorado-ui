FROM ruby:2.5
# Probably works with 2.7.2 now

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler:1.17.1  ; # gem install bundler && bundle update --bundler
RUN bundle install

COPY . .

# Launch config.ru via rackup
EXPOSE 9292
CMD ["bundle exec rackup", "-o","0.0.0.0"]
