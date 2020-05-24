FROM ruby:2.6.6

# Create a local folder for the app assets
RUN mkdir /backend
WORKDIR /backend

# Install required tooling
RUN apt-get update && apt-get install -qq -y build-essential nodejs libpq-dev postgresql-client --fix-missing --no-install-recommends

# Copy and install Gems from our Gemfile
COPY Gemfile /backend/Gemfile 
COPY Gemfile.lock /backend/Gemfile.lock

RUN gem install bundler -v 2.1.4
RUN bundle config set deployment 'true'
RUN bundle install

COPY . ./

EXPOSE 3000

# Start the puma server
CMD bundle exec puma -p 3000