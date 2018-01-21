#!/bin/sh

##############################################################################################
# Title:          phpdevenv.sh
# Description:    Most required dependencies to setup your PHP Development Environment
# Author:         Mourad Soltani <mouradevsoltani@gmail.com>
# Date            21012018
# Usage:          sudo chmod +x phpdevenv.sh && ./phpdevenv.sh
##############################################################################################

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Cyan='\033[0;36m'         # Cyan

# Bash script to check if service is running. Usage: checkservice $SERVICE 
checkservice(){
echo "$Cyan \n $(tput bold)Checking service $1 ..... $Color_Off"
	if ps ax | grep -v grep | grep $1 > /dev/null
	then
	    echo "$Green $(tput bold)$1 running, everything is fine! $Color_Off"
	else
	    echo "$Red $(tput bold)$1 is not running! $Color_Off"
	fi
}

# Start Installation
echo "$Yellow ============================================================================== $Color_Off"
echo "$Yellow  $(tput bold)Please be Patient: Installation will start now... It may take some time :) $Color_Off"
echo "$Yellow ============================================================================== $Color_Off"

# Update packages
echo "$Cyan \n $(tput bold)Updating packages & upgrading system..... $Color_Off"
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get autoremove -y
echo "$Green $(tput bold)Packages Updated Successfully! $color_off"

# Install Apache
echo "$Cyan \n $(tput bold)Installing Apache..... $Color_Off"
sudo apt-get install apache2 -y
echo "$Green $(tput bold)Apache Installed Successfully! $color_off"

# Check Firewall Configurations
echo "$Cyan \n $(tput bold)Your firewall configuration is: $Color_Off"
sudo ufw app list
sudo ufw allow 'Apache Full'
sudo ufw status
echo "$Green $(tput bold)Firewall Configured Successfully! $color_off"

# Check Apache status
checkservice "apache2"

# Install cURL
echo "$Cyan \n $(tput bold)Installing cURL..... $Color_Off"
sudo apt-get install curl -y
echo "$Green $(tput bold)cURL Installed Successfully! $color_off"

# Install MySQL Server
echo "$Cyan \n $(tput bold)Installing MySQL Server..... $Color_Off"
sudo apt-get install mysql-server -y
echo "$Green $(tput bold)MySQL Server Installed Successfully! $color_off"

# Install PHP
echo "$Cyan \n $(tput bold)Adding PHP repository $Color_Off"
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y
echo "$Green $(tput bold)Packages updated Successfully $Color_Off"

echo "$Cyan \n $(tput bold)Installing PHP... $Color_Off"
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql
echo "$Green $(tput bold)PHP Installed Successfully! $color_off"

# Install PHP Required Extensions
echo "$Cyan \n $(tput bold)Installing PHP Required Extensions... $Color_Off"
sudo apt-get install php-cli php-curl php-json php-mbstring php-gettext php-gd php-zip
echo "$Green $(tput bold)PHP Required Extensions Installed Successfully! $color_off"

# Install phpmyadmin
echo "$Cyan \n $(tput bold)Installing phpMyAdmin $Color_Off"
sudo apt-get install phpmyadmin
echo "$Green $(tput bold)phpMyAdmin Installed Successfully $Color_Off"

# Enable Apache Rewrite Module
echo "$Cyan \n $(tput bold)Enabling Apache Rewrite && SSL Module $Color_Off"
sudo a2enmod rewrite
sudo a2enmod ssl
echo "$Green $(tput bold)Apache Rewrite Module Enabled && SSL Successfully $Color_Off"

# Restart Apache
echo "$Cyan \n $(tput bold)Restart Apache $Color_Off"
sudo service apache2 restart
checkservice "apache2"

# Install GIT
echo "$Cyan \n $(tput bold)Installing Git..... $Color_Off"
sudo apt-get install git -y
echo "$Green $(tput bold)Git Installed Successfully! $color_off"

# Install Composer
echo "$Cyan \n $(tput bold)Installing Composer..... $Color_Off"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
echo "$Green $(tput bold)Composer Installed Successfully! $color_off"

# End Installation
echo "$Yellow \n \n $(tput bold)Installation Completed Successfully! $Color_Off"
echo "$Yellow $(tput bold)End of script. ;) $Color_Off"