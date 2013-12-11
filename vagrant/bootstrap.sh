#!/usr/bin/env bash
echo "Project specific setup ..."
if [ -f "bootstrap.txt" ]
then
    echo "Already provisioned."
    exit 0
fi
echo "Updating Ubuntu ..."
apt-get update

echo "Installing oracle jdk 1.7 ..."
rm -rf /usr/local/java	
mkdir -p /usr/local/java
cp /vagrant/vagrant/jdk* /usr/local/java
cd /usr/local/java
chmod a+x jdk*
tar -xzf jdk*
rm jdk*.tar.gz
mv jdk* jdk1.7.0

echo "PATH=$PATH:/usr/local/java/jdk1.7.0/bin" > /etc/environment
echo "JAVA_HOME=/usr/local/java/jdk1.7.0" >> /etc/environment

echo "Installing Apache Tomcat 7 ..."
apt-get -q -y install tomcat7

echo "Setting oracle java as default jdk ..."
update-alternatives --install "/usr/bin/java" java "/usr/local/java/jdk1.7.0/bin/java" 1
update-alternatives --set java /usr/local/java/jdk1.7.0/bin/java

update-alternatives --install "/usr/bin/javaws" javaws "/usr/local/java/jdk1.7.0/bin/javaws" 1
update-alternatives --set javaws /usr/local/java/jdk1.7.0/bin/javaws

cd /usr/lib/jvm
rm default-java
ln -s /usr/local/java/jdk1.7.0 default-java

echo "Installing Mongo DB ..."
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
apt-get update
apt-get install mongodb-10gen
mkdir /data
mkdir /data/db
service mongodb restart

echo "Linking the project war file ..."
service tomcat7 stop
cd /var/lib/tomcat7/webapps
ln -s /vagrant/build/libs/SimpleRestApp.war
service tomcat7 start
cd /home/vagrant
#touch bootstrap.txt
