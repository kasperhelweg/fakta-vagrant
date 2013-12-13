#!/usr/bin/env bash
#
# This bootstraps Puppet on Ubuntu 12.04 LTS.
#
set -e

echo "Script being run as:"
whoami

# Touch bash profile
touch $HOME/.bash_profile

echo "Configuring wordpress..."
# Install workdpress
cd /var/www
wget http://wordpress.org/latest.tar.gz > /dev/null 2>&1
tar -xzvf latest.tar.gz > /dev/null 2>&1
rm ./latest.tar.gz > /dev/null 2>&1
cd ./wordpress

sed -i "s/'database_name_here'/'wordpress'/g" wp-config-sample.php
sed -i "s/'username_here'/'vagrant'/g" wp-config-sample.php
sed -i "s/'password_here'/'vagrant'/g" wp-config-sample.php

# REMEMBER TO ADD 
#  // Enable WP_DEBUG mode
# define('WP_DEBUG', true);
mv wp-config-sample.php wp-config.php

#/usr/bin/php -r "
#include './wp-admin/install.php';
#wp_install('Fakta CMS', 'admin', 'fakta_adm@fakta_dev.dk', 1, '', '1234');
#" > /dev/null 2>&1
echo "Wordpress installed!"
echo "goto 'localhost:4000/wordpress' to finish installation"

echo "Configuring Postgres..."
sudo -u postgres psql -c "ALTER ROLE postgres WITH PASSWORD 'postgres';" > /dev/null 2>&1
sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';" > /dev/null 2>&1
sudo -u postgres psql -c "CREATE DATABASE fakta_development ENCODING 'UTF8' OWNER vagrant;" > /dev/null 2>&1 
sudo -u postgres psql -c "CREATE DATABASE fakta_test ENCODING 'UTF8' OWNER vagrant;" > /dev/null 2>&1
echo "Restarting Postgres..."
sudo /etc/init.d/postgresql restart > /dev/null 2>&1
echo "Postgres DB psql -l..."
sudo -u postgres psql -l 

# Install rvm for ruby
echo "Installing rvm..."
curl -L https://get.rvm.io | bash > /dev/null 2>&1
source ~/.rvm/scripts/rvm

echo 'source ~/.profile' >> ~/.bash_profile
echo 'source ~/.bashrc' >> ~/.bash_profile
echo '[[ -s "~/.rvm/scripts/rvm" ]] && source "~/.rvm/scripts/rvm"' >> ~/.bash_profile

echo "Is rvm a function?"
type rvm | head -1

# Install Ruby 1.9.3
echo "Installing ruby 1.9.3"
rvm install 1.9.3 > /dev/null 2>&1
rvm use 1.9.3 > /dev/null 2>&1

echo "Creating gemset 'fakta'"
rvm gemset create fakta
