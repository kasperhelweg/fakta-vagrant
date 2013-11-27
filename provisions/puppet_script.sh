#!/usr/bin/env bash
#
# This bootstraps Puppet on Ubuntu 12.04 LTS.
#
set -e

echo "Script being run as:"
whoami

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
echo "Installing GIT..."
apt-get install -y git-core > /dev/null 2>&1

# Install the PuppetLabs repo
echo "Configuring PuppetLabs repo..."
repo_deb_path=$(mktemp)
wget --output-document=${repo_deb_path} ${REPO_DEB_URL} 2>/dev/null
dpkg -i ${repo_deb_path} >/dev/null
apt-get update >/dev/null

# Install Puppet
echo "Installing Puppet..."
apt-get install -y puppet > /dev/null 2>&1
echo "Puppet installed!"

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

echo "Installing dep. libs...(be patient)"
#Nokogiri
apt-get install -y openssl > /dev/null 2>&1
#Capybare-webkit
apt-get install -y libqt4-dev libqtwebkit-dev > /dev/null 2>&1
#Nokogiri
apt-get install -y libxslt-dev libxml2-dev > /dev/null 2>&1
#rmagick
apt-get install -y imagemagick libmagickwand-dev > /dev/null 2>&1
