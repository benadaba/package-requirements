#  **<span style="color:green">DataPandas.</span>**
### **<span style="color:green">Contacts: cs@datapandas.com<br> WebSite : <http://datapandas.com/></span>**
### **Email: cs@datapandas.com**

## INSTALLATION WITH DOCKER ON AMAZONLINUX 2023
 Tune Linux system limits, often to meet the requirements of high-performance applications like Elasticsearch, Docker, or large Java-based services. 
 
`sysctl -w vm.max_map_count=524288`  
`sysctl -w fs.file-max=131072`  
`ulimit -n 131072` 
`ulimit -u 8192` 

### install docker
`sudo yum install docker -y`
`sudo systemctl start docker`
`sudo systemctl status docker`


### Run sonarqube containers
`docker run -d   --name sonarqube   -p 9000:9000   -v sonarqube_data:/opt/sonarqube/data   -v sonarqube_logs:/opt/sonarqube/logs   -v sonarqube_extensions:/opt/sonarqube/extensions   sonarqube:lts`

### 7. Ensure that SonarQube is running and Access sonarQube on the browser
# sonarqube default port is = 9000
# get the sonarqube public ip address 
# publicIP:9000
------------------

## SonarQube Installation And Setup In AWS EC2 Redhat Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 T2.medium Instance with 4GB RAM.
+ Create Security Group and open Required ports.
   + 9000 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+ for SonarQube version 7.8

## 1. Create sonar user to manage the SonarQube server
```sh
#As a good security practice, SonarQuber Server is not advised to run sonar service as a root user, 
# create a new user called sonar and grant sudo access to manage sonar services as follows

sudo useradd sonar
# Grand sudo access to sonar user
sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
# set hostname for the sonarqube server
sudo hostnamectl set-hostname sonar 
sudo su - sonar
```
## 1b. Assign password to sonar user
```sh
sudo passwd sonar
```
## 2. Enable PasswordAuthentication in the server
```sh
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
```
### 3. Install Java JDK 1.8+ required for sonarqube to start

``` sh
cd /opt
sudo yum -y install unzip wget git
#sudo yum install  java-11-openjdk-devel
sudo yum install java -y
```
### 4. Download and extract the SonarqQube Server software.
```sh
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.8.zip
sudo unzip sonarqube-7.8.zip
sudo rm -rf sonarqube-7.8.zip
sudo mv sonarqube-7.8 sonarqube
```

## 5. Grant file permissions for sonar user to start and manage sonarQube
```sh
sudo chown -R sonar:sonar /opt/sonarqube/
sudo chmod -R 775 /opt/sonarqube/
```
### 6. start sonarQube server
```sh
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start 
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
```

### 7. Ensure that SonarQube is running and Access sonarQube on the browser
# sonarqube default port is = 9000
# get the sonarqube public ip address 
# publicIP:9000
```sh
curl -v localhost:9000
54.236.232.85:9000
default USERNAME: admin
default password: admin
```
