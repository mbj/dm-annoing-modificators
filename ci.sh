#!/bin/bash
source ~/.profile
rvm use ruby-1.9.2
gem install bundler
bundle install
bundle exec rspec spec
