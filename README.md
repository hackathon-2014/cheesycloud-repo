cheesycloud-repo
================

cheesycloud-repo repository


#!/bin/bash

sudo apt-get update
sudo apt-get install postgresql openjdk-7-jdk git-core unzip -y

export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64/

curl -s get.gvmtool.net | bash
source "/home/$USER/.gvm/bin/gvm-init.sh"
gvm install grails 2.3.11


sudo -u postgres psql -c "CREATE DATABASE food_run;"
sudo -u postgres psql -c "CREATE USER food_run WITH PASSWORD 'food_run';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE food_run to food_run;"

git clone https://github.com/hackathon-2014/cheesycloud-repo.git

cd cheesycloud-repo
grails run-app
