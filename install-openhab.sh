#!/bin/bash

## Update and Prepare
sudo apt update && sudo apt upgrade -y

## Install openjdk-8 (not recommended on ARM)
#sudo apt install openjdk-8-jre -y
#java -version

## Install Oracle-java8 dependency (requires license)
#sudo apt-get install oracle-java8-jdk -y 
#java -version

## Alternately install Azul Zulu java8
# Import Azul's public key
#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
# If the apt-add-repository is not available, use this alternate command (Debian Squeeze)
#sudo echo 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
# Add the Azul package to the APT repository
#sudo apt-get install software-properties-common -y
#sudo apt-add-repository 'deb http://repos.azulsystems.com/debian stable main'
# Update the information about available packages.
#sudo apt-get update
# Install Zulu
#sudo apt-get install zulu-8
#java -version

## Install eclipse
which eclipse
sudo apt-get install eclipse -y

## Install OpenHAB
# Add the openHAB 2 Bintray repository key to your package manager 

#wget https://bintray.com/artifact/download/openhab/bin/distribution-2.5.3-runtime.zip
wget -qO - 'https://bintray.com/user/downloadSubjectPublicKey?username=openhab' | sudo apt-key add -

# Allow Apt to use the HTTPS Protocol
sudo apt-get install apt-transport-https -y

# Add the openHAB 2 Stable Repository to your systems apt sources list
echo 'deb https://dl.bintray.com/openhab/apt-repo2 stable main' | sudo tee /etc/apt/sources.list.d/openhab2.list

# install
sudo apt-get update && sudo apt-get install openhab2 openhab2-addons -yy

## Start OpenHAB services
sudo systemctl start openhab2.service
sudo systemctl daemon-reload
sudo systemctl enable openhab2.service
sudo systemctl status openhab2.service

## Provide OpenHAB appropriate permissions
sudo adduser openhab dialout
sudo adduser openhab tty

## Install Mosquitto
#apt-cache search mosquitto
sudo apt install mosquitto mosquitto-clients -yy

sudo cp /etc/mosquitto/mosquitto.conf /etc/mosquitto/mosquitto.conf.bak
sudo echo "allow_anonymous fasle" >> /etc/mosquitto/mosquitto.conf
sudo echo "password_file /etc/mosquitto/pwfile" >> /etc/mosquitto/mosquitto.conf
sudo echo "listener 1883" >> /etc/mosquitto/mosquitto.conf
#sudo nano /etc/mosquitto/mosquitto.conf 

# Creat mqtt password for user "pi"
sudo mosquitto_passwd -c /etc/mosquitto/pwfile pi

# Test mqtt
# Subscrib to "test" topic
mosquitto_sub -d -u pi -P $PASSWD -t test
# Publish "test" topic
mosquitto_pub -d -u pi -P $PASSWD -t test -m "Hello, World!"
