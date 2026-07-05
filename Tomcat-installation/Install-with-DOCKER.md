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
8.  `docker run -d --name tomcat   -p 8080:8080   -v tomcatdata:/usr/local/tomcat/webapps   tomcat:8.0.20-jre8`    



