#!/bin/bash
echo "Searching for apps..."

if [ -d "/vagrant/fakta-backend" ]; then
    cd /vagrant/fakta-backend
    echo "setting up: fakta-backend"
    echo "Running bundle"
    bundle update debugger-ruby_core_source
    bundle install
    echo "Running migrations"
    #mv ./config/database.yml.vagrant ./config/database.yml
    echo "Development"
    rake db:migrate RAILS_ENV=development > /dev/null 2>&1
    echo "Test"
    rake db:migrate RAILS_ENV=test > /dev/null 2>&1
    echo "fakta-backend prepared"
fi
