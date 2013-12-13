#!/usr/bin/env bash
set -e
source ~/.rvm/scripts/rvm

echo "----------Searching for apps----------"
if [ -d "/vagrant/fakta-backend" ]; then
    cd /vagrant/fakta-backend
    echo "----<setting up: fakta-backend>----"
    echo "Running bundle"
    bundle update debugger-ruby_core_source
    bundle install
    echo "----<Running migrations>----"
    echo "--<Development>--"
    rake db:migrate RAILS_ENV=development > /dev/null 2>&1
    echo "--<Test>--"
    rake db:migrate RAILS_ENV=test > /dev/null 2>&1
    echo "----<fakta-backend prepared>----"
fi
if [ -d "/vagrant/fakta-wordpress-plugin" ]; then
    echo "----<setting up: fakta-wordpress-plugin>----"
    #cd /var/www/wordpress/wp-content/plugins/fakta-wordpress-plugin
    #ln -s /vagrant/fakta-wordpress-plugin/ fakta-wordpress-plugin
    echo "----<fakta-wordpress-plugin prepared>----"
    # Link folder into apache wordpress    
fi
