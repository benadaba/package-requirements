#  **<span style="color:green">DataPandas.</span>**
### **<span style="color:green">Contacts: cs@datapandas.com<br> WebSite : <http://datapandas.com/></span>**
### **Email: cs@datapandas.com**



## Apache Maven Installation And Setup In AWS EC2 Redhat Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Security Group and open Required ports.
   + 22 ..etc
+ Create Redhat EC2 T2.medium Instance with 4GB of RAM.
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+

### Install Java JDK 11+  and other softares (GIT, wget and tree)

``` sh
# install Java JDK 11+ as a pre-requisit for maven to run.

sudo hostnamectl set-hostname maven
sudo su - ec2-user
cd /opt
sudo yum update -y
sudo yum install wget nano tree unzip git-all -y
sudo yum install java -y
#sudo yum install java-21-openjdk-devel java-1.8.0-openjdk-devel -y
java -version
git --version
```

## 2. Download, extract and Install Maven
``` sh
#Step1) Download the Maven Software
#sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.2/binaries/apache-maven-3.9.2-bin.zip
# sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.zip
# sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.10/binaries/apache-maven-3.9.10-bin.zip
sudo wget https://archive.apache.org/dist/maven/maven-3/3.9.10/binaries/apache-maven-3.9.10-bin.zip
sudo unzip apache-maven-3.9.10-bin.zip
sudo rm -rf apache-maven-3.9.10-bin.zip
sudo mv apache-maven-3.9.10/ maven
sudo mv maven /opt/
```
## .#Step3) Set Environmental Variable  - For Specific User eg ec2-user
``` sh
vi ~/.bash_profile  # and add the lines below
export M2_HOME=/opt/maven
export PATH=$PATH:$M2_HOME/bin
```
## .#Step4) Refresh the profile file and Verify if maven is running
```sh
source ~/.bash_profile
mvn -version
```

