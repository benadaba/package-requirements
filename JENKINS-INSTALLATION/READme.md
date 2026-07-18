#  **<span style="color:green">DataPandas.</span>**
### **<span style="color:green">Contacts: cs@datapandas.com<br> WebSite : <http://datapandas.com/></span>**
### **Email: cs@datapandas.com**


## Jenkins Installation And Setup In AWS EC2 Amazon linux 2023 or Redhat Instnace.
##### Prerequisite
+ AWS Acccount.
+ Create AWS EC2 Amazon linux 2023 or Redhat EC2 t2.medium Instance with 4GB RAM.
+ Create Security Group and open Required ports.
   + 8080 got Jenkins, ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+ for SonarQube version 7.8

### 
``` sh
sudo useradd jenkins
# Grand sudo access to jenkins user
sudo echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins
# set hostname for the sonarqube server
sudo hostnamectl set-hostname jenkins 
sudo su - jenkins
```
### Install Java JDK 1.8+ as Jenkins pre-requisit
### Install other softwares - git, unzip and wget

``` sh
sudo hostnamectl set-hostname ci
sudo yum -y install unzip wget tree git
#sudo yum install java-11-openjdk -y
sudo yum install java-21-amazon-corretto-headless
```
###  Add Jenkins Repository and key
```sh
#sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
#cd /etc/yum.repos.d/
#sudo curl -O https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

```

## Install Jenkins
```sh
#sudo yum -y install jenkins  --nobest
#sudo  yum install fontconfig java-17-openjdk
sudo  yum install jenkins
```

## Point jenkins to the java 21 home (optional)
```sh
#vi /usr/lib/systemd/system/jenkins.service

#look for  a line that looks like
#Environment="JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"

#replace it with
#Environment="JAVA_HOME=/usr/bin/java"
```


# start Jenkins  service and verify Jenkins is running
```sh
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
```
# Access Jenkins from the browser
```sh
public-ip:8080
curl ifconfig.co 
```
# get jenkins initial admin password
```sh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

