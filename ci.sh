#!/bin/bash -e
# This is a script for our company ci server. Ignore!
source /etc/profile
rvm use ruby-1.9.3
gem install bundler --user
bundle install --path vendor
bundle exec rspec spec
