#!/usr/bin/env bash
echo "Project specific setup ..."
if [ -f "bootstrap.txt" ]
then
    echo "Already provisioned."
    exit 0
fi
echo "Updating Ubuntu ..."
sudo apt-get update

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
sudo apt-get -q -y install tomcat7

echo "Setting oracle java as default jdk ..."
sudo update-alternatives --install "/usr/bin/java" java "/usr/local/java/jdk1.7.0/bin/java" 1
sudo update-alternatives --set java /usr/local/java/jdk1.7.0/bin/java

sudo update-alternatives --install "/usr/bin/javaws" javaws "/usr/local/java/jdk1.7.0/bin/javaws" 1
sudo update-alternatives --set javaws /usr/local/java/jdk1.7.0/bin/javaws

cd /home/vagrant
#touch bootstrap.txt
