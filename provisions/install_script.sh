#!/usr/bin/env bash
#
# This bootstraps Puppet on Ubuntu 12.04 LTS.
#
set -e

echo "Script being run as:"
whoami

# Touch bash profile
touch $HOME/.bash_profile

echo "Configuring Postgres..."
sudo -u postgres psql -c "ALTER ROLE postgres WITH PASSWORD 'postgres';"
sudo -u postgres psql -c "CREATE USER vagrant WITH PASSWORD 'vagrant';"
sudo -u postgres psql -c "CREATE DATABASE fakta_development ENCODING 'UTF8' OWNER vagrant;" 
sudo -u postgres psql -c "CREATE DATABASE fakta_test ENCODING 'UTF8' OWNER vagrant;" 
echo "Restarting Postgres..."
sudo /etc/init.d/postgresql restart
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
