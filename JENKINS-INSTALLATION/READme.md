#  **<span style="color:green">DataPandas.</span>**
### **<span style="color:green">Contacts: cs@datapandas.com<br> WebSite : <http://datapandas.com/></span>**
### **Email: cs@datapandas.com**

## INSTALLATION WITH DOCKER ON AMAZONLINUX 2023
 Tune Linux system limits, often to meet the requirements of high-performance applications like Elasticsearch, Docker, or large Java-based services. 
 
`sudo sysctl -w vm.max_map_count=524288`    
`sudo sysctl -w fs.file-max=131072`   
`sudo ulimit -n 131072`  
`sudo ulimit -u 8192`  

### install docker  
`sudo yum install docker -y`  
`sudo systemctl start docker`  
`sudo systemctl status docker`  

### add ec2-user to the docker group  
`sudo usermod -aG docker ec2-user`  
`sudo su - ec2-user`  


### pull docker image  
`docker pull jenkins/jenkins:lts-jdk17`  

### scan image with trivy   
#### Download and install Trivy  
`TRIVY_VERSION=$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep tag_name | cut -d '"' -f 4)`  
`wget https://github.com/aquasecurity/trivy/releases/download/${TRIVY_VERSION}/trivy_${TRIVY_VERSION#v}_Linux-64bit.tar.gz`  

`tar -zxvf trivy_${TRIVY_VERSION#v}_Linux-64bit.tar.gz`   
`sudo mv trivy /usr/local/bin/`   


#### Verify the installation
`trivy --version`   

#### Run a scan   
`trivy image jenkins/jenkins:lts-jdk17`  

### build jenkins image with docker installed jenkins containers  
`FROM jenkins/jenkins:lts

USER root

#Install Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    rm -rf /var/lib/apt/lists/*

#Create docker group if it doesn't exist and add jenkins user to it
RUN groupadd -f docker && \
    usermod -aG docker jenkins

#Switch back to Jenkins user
#USER jenkins`

### Run jenkins containers
`docker build -t jenkins-with-docker .`
### Run jenkins containers  
`docker run -d \
  --name jenkins-docker \
  -p 8080:8080 -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  jenkins-with-docker`

### 7. Ensure that Jenkins is running and Access Jenkins on the browser
 jenkins default port is = 8080
 get the jenkins public ip address 
 publicIP:9000

Once your instance is up and running, Log in to http://localhost:8080 
get initial password :

`docker exec -it <container-id> cat /var/jenkins_home/secrets/initialAdminPassword`

------------------
### Jenkins docker references:  
https://hub.docker.com/r/jenkins/jenkins   
https://github.com/jenkinsci/docker/blob/master/README.md    



## Jenkins Installation And Setup In AWS EC2 Redhat Instnace.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 t2.medium Instance with 4GB RAM.
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
sudo yum install java-11-openjdk -y
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
sudo  yum install fontconfig java-17-openjdk
sudo  yum install jenkins
```
# start Jenkins  service and verify Jenkins is running
```sh
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

