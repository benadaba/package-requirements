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


### pull docker image  
`docker pull sonatype/nexus`  
`docker images`

### scan image with trivy   
#### Download and install Trivy  
`TRIVY_VERSION=$(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest | grep tag_name | cut -d '"' -f 4)`  
`wget https://github.com/aquasecurity/trivy/releases/download/${TRIVY_VERSION}/trivy_${TRIVY_VERSION#v}_Linux-64bit.tar.gz`  

`tar -zxvf trivy_${TRIVY_VERSION#v}_Linux-64bit.tar.gz`   
`sudo mv trivy /usr/local/bin/`   


#### Verify the installation
`trivy --version`   

#### Run a scan   
`trivy image sonatype/nexus`  


### Run Nexus containers  

`docker run -d -p 8081:8081 --name nexus sonatype/nexus:oss`   

OR  

`mkdir -p /opt/nexus-data && chown -R 200 /opt/nexus-data`   

`docker run -d -p 8081:8081 --name nexus -v /opt/nexus-data:/sonatype-work sonatype/nexus:oss`

### 7. Ensure that Nexus is running and Access nexus on the browser
 Nexus default port is = 8081
 get the Nexus public ip address 
 publicIP:8081

Once your instance is up and running, Log in to http://localhost:8080 
get initial password :   

Default credentials are: `admin / admin123`  
**OR**  
Check the initial login pop-up window for the location of the temporary password
