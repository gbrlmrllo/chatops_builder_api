![CI](https://github.com/gbrlmrllo/chatops_builder_api/workflows/CI/badge.svg)

**ChatOps Builder** is an app that allows you to centralize your notification events in order to monitor them and also be able to integrate them into applications such as [Slack](https://slack.com/intl/es-ar/), [SendGrid](https://sendgrid.com/), [Microsoft Teams](https://www.microsoft.com/es-ar/microsoft-365/microsoft-teams/group-chat-software), and many more.

## Associated services

* Enable [Github Actions CI](https://help.github.com/en/actions/building-and-testing-code-with-continuous-integration/setting-up-continuous-integration-using-github-actions) Continuous Integration

## Installation

Setup JWT secret for [devise](https://github.com/gbrlmrllo/chatops_builder_api/blob/master/config/initializers/devise.rb#L302).

```
export JWT_SECRET_KEY="you can use "rails secret" for generate a secret token"
```

Run application setup

```
./bin/setup
```

## Gemfile

To see the latest and greatest gems, look at
[Gemfile](https://github.com/gbrlmrllo/chatops_builder_api/blob/master/Gemfile)

It includes application gems like:

* [Sidekiq](https://github.com/mperham/sidekiq) for background
  processing
* [Devise jwt](https://github.com/waiting-for-dev/devise-jwt) for user authentication
* [Faraday](https://github.com/lostisland/faraday) for http client interface
* [Oj](http://www.ohler.com/oj/) A fast JSON parser and Object
* [Postgres](https://github.com/ged/ruby-pg) for access to the Postgres database
* [Recipient Interceptor](https://github.com/croaky/recipient_interceptor) to
  avoid accidentally sending emails to real people from staging
  
And development gems like:

* [Pry Rails](https://github.com/rweng/pry-rails) for interactively exploring
  objects
* [ByeBug](https://github.com/deivid-rodriguez/byebug) for interactively
  debugging behavior
* [Bullet](https://github.com/flyerhzm/bullet) for help to kill N+1 queries and
  unused eager loading
* [Spring](https://github.com/rails/spring) for fast Rails actions via
  pre-loading
* [Rubocop rails](https://github.com/rubocop-hq/rubocop-rails) for enforcing Rails best practices and coding conventions.

And testing gems like:

* [Capybara](https://github.com/jnicklas/capybara)
* [Factory Bot](https://github.com/thoughtbot/factory_bot) for test data
* [RSpec](https://github.com/rspec/rspec) for unit testing
* [RSpec Mocks](https://github.com/rspec/rspec-mocks) for stubbing and spying
* [Shoulda Matchers](https://github.com/thoughtbot/shoulda-matchers) for common
  RSpec matchers

## Github CI

You must add a `JWT_SECRET_KEY` in the [github secrets](https://help.github.com/es/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets)

## Spring

rails_api_boilerplate uses [spring](https://github.com/rails/spring) by default.
It makes Rails applications load faster, but it might introduce confusing issues
around stale code not being refreshed.
If you think your application is running old code, run `spring stop`.
And if you'd rather not use spring, add `DISABLE_SPRING=1` to your login file.
