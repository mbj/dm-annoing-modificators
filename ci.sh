#!/bin/bash
source ~/.profile
rvm use ruby-1.9.2
rvm gemset create dm-annoing-modificators
rvm gemset use dm-annoing-modificators
gem install bundler
bundle install
bundle exec rspec spec
#bundle exec cucumber features