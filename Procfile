web: bundle exec puma -p $PORT -C ./config/puma.rb
release: bin/rails db:migrate
worker: bundle exec rails jobs:work
