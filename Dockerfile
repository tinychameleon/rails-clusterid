ARG RUBY_VERSION
FROM ruby:$RUBY_VERSION

WORKDIR /workspace
RUN mkdir -p lib/rails-clusterid
COPY Gemfile Gemfile.lock rails-clusterid.gemspec ./
COPY lib/rails-clusterid/version.rb ./lib/rails-clusterid/
RUN gem install bundler:2.3.3 && bundle install
