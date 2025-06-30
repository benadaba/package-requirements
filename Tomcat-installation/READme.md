#  **<span style="color:green">DataPandas.</span>**
### **<span style="color:green">Contacts: cs@datapandas.com<br> WebSite : <http://datapandas.com/></span>**
### **Email: cs@datapandas.com**

## Installing Tomcat Using Docker
##### Prerequisite
1. ### Use Amazon Linux Instance
2. install docker
3. `sudo yum install docker -y`

### start docker
4.  `sudo systemctl start docker`
5.  `sudo systemctl status docker`
6.  `sudo usermod -aG docker ec2-user`
7.  `sudo su - ec2-user`


### Pull docker image 
7.  `docker pull tomcat:8.0.20-jre8`

### run docker
8.  `docker run -d --name tomcat   -p 8080:8080   -v $(pwd)/tomcatdata:/usr/local/tomcat/webapps   tomcat:8.0.20-jre8`    




## Apache Tomcat Installation And Setup In AWS EC2 Redhat Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 T2.micro Instance.
+ Create Security Group and open Tomcat ports or Required ports.
   + 8080 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+

### Install Java JDK 1.8+ 

``` sh
# change hostname to tomcat
sudo hostnamectl set-hostname tomcat
sudo su - ec2-user
cd /opt 
# install Java JDK 1.8+ as a pre-requisit for tomcat to run.
sudo yum install git wget -y
sudo yum install java-1.8.0-openjdk-devel -y
# install wget unzip packages.
sudo yum install wget unzip -y
```
## Install Tomcat version 9.0.97
### Download and extract the tomcat server
``` sh
#sudo wget  https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.zip
#sudo wget  https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.97/bin/apache-tomcat-9.0.97.zip
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.98/bin/apache-tomcat-9.0.98.zip
sudo unzip apache-tomcat-9.0.98.zip
sudo rm -rf apache-tomcat-9.0.98.zip
### rename tomcat for good naming convention
sudo mv apache-tomcat-9.0.98 tomcat9  
### assign executable permissions to the tomcat home directory
sudo chmod 777 -R /opt/tomcat9
sudo chown ec2-user -R /opt/tomcat9
### start tomcat
sh /opt/tomcat9/bin/startup.sh
# create a soft link to start and stop tomcat
# This will enable us to manage tomcat as a service
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
starttomcat
sudo su - ec2-user
```

