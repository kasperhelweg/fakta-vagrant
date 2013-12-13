#!/usr/bin/env bash
#
# This bootstraps Puppet on Ubuntu 12.04 LTS.
#
set -e

echo "Script being run as:"
whoami

#No prompts
#export DEBIAN_FRONTEND=noninteractive

# Load up the release information
. /etc/lsb-release

REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb"

#--------------------------------------------------------------------
# NO TUNABLES BELOW THIS POINT
#--------------------------------------------------------------------
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Do the initial apt-get update
echo "Initial apt-get update.."
apt-get update >/dev/null
#apt-get upgrade -y >/dev/null

export LANGUAGE="en_DK.UTF-8"
export LANG="en_DK.UTF-8"
export LC_ALL="en_DK.UTF-8"
locale-gen en_DK.UTF-8
dpkg-reconfigure locales

# Install wget if we have to (some older Ubuntu versions)
echo "Installing wget..."
apt-get install -y wget > /dev/null 2>&1

# Install curl if we have to (some older Ubuntu versions)
echo "Installing curl..."
apt-get install -y curl > /dev/null 2>&1

# Install curl if we have to (some older Ubuntu versions)
echo "Installing git..."
apt-get install -y git-core > /dev/null 2>&1

echo "Installing console..."
apt-get install -y rxvt-unicode-256color > /dev/null 2>&1

echo "Installing dep. libs...(be patient)"
#Nokogiri
apt-get install -y openssl > /dev/null 2>&1
#Capybare-webkit
apt-get install -y libqt4-dev libqtwebkit-dev > /dev/null 2>&1
#Nokogiri
apt-get install -y libxslt-dev libxml2-dev > /dev/null 2>&1
#rmagick
apt-get install -y imagemagick libmagickwand-dev > /dev/null 2>&1

# Install the PuppetLabs repo
#echo "Configuring PuppetLabs repo..."
#repo_deb_path=$(mktemp)
#wget --output-document=${repo_deb_path} ${REPO_DEB_URL} 2>/dev/null
#dpkg -i ${repo_deb_path} >/dev/null
#apt-get update >/dev/null

# Install Puppet
#echo "Installing Puppet..."
#apt-get install -y puppet > /dev/null 2>&1
#echo "Puppet installed!"

# Install apache
echo "Installing Apache..."
apt-get install -y apache2 > /dev/null 2>&1
chown vagrant /var/www 
echo "Apache installed!"

# PHP
echo "Installing PHP..."
apt-get install -y libapache2-mod-php5 > /dev/null 2>&1
apt-get install -y php5-curl > /dev/null 2>&1
touch /var/www/info.php
echo "<?php phpinfo(); ?>" > /var/www/info.php
echo "PHP installed!"

echo "* restarting apache"
service apache2 restart > /dev/null 2>&1

# MySQL
echo "Installing MySQL..."
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

apt-get install -y mysql-server libapache2-mod-auth-mysql php5-mysql > /dev/null 2>&1
echo "MySQL installed!"

# MySQL DB setup
# -uroot -proot means user root with password root
if [ ! -f /var/log/databasesetup ];
then
    echo "CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant'" | mysql -uroot -proot
    echo "CREATE DATABASE wordpress" | mysql -uroot -proot
    echo "GRANT ALL ON wordpress.* TO 'vagrant'@'localhost'" | mysql -uroot -proot
    echo "flush privileges" | mysql -uroot -proot

    touch /var/log/databasesetup

    #if [ -f /vagrant/data/initial.sql ];
    #then
    #    mysql -uroot -prootpass wordpress < /vagrant/data/initial.sql
    #fi
fi

echo "* restarting apache"
service apache2 restart > /dev/null 2>&1

# Install Redis
echo "Installing Redis..."
apt-get install -y redis-server > /dev/null 2>&1
echo "Redis installed!"

echo "Installing Postgres..."
apt-get install -y postgresql postgresql-contrib libpq-dev > /dev/null 2>&1
echo "Postgres installed"

echo "Installing node..."
apt-get install -y nodejs npm > /dev/null 2>&1
echo "Done..."
