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


## Nexus Installation And Setup In AWS EC2 Redhat Instance.
##### Pre-requisite
+ AWS Acccount.
+ Create Redhat EC2 t2.medium Instance with 4GB RAM.
+ Feel free to use Redhat EC2 t2.large Instance with 8GB RAM if your instance keeps crushing. 
+ Create Security Group and open Required ports.
   + 8081 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+ for Nexus version 3.15

## Create nexus user to manage the Nexus server
```sh
#As a good security practice, Nexus is not advised to run nexus service as a root user, 
# so create a new user called nexus and grant sudo access to manage nexus services as follows. 
sudo hostnamectl set-hostname nexus
sudo useradd nexus
# Grand sudo access to nexus user
sudo echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus
sudo su - nexus
```

### Install Java as a pre-requisit for nexus and other softwares

``` sh
cd /opt
sudo yum install wget git nano unzip -y
#sudo yum install java-11-openjdk-devel java-1.8.0-openjdk-devel -y
sudo yum install java -y
```
### Download nexus software and extract it (unzip).
```sh
#sudo wget http://download.sonatype.com/nexus/3/nexus-3.15.2-01-unix.tar.gz
sudo wget https://download.sonatype.com/nexus/3/nexus-3.82.0-08-linux-x86_64.tar.gz
sudo tar -zxvf nexus-3.82.0-08-linux-x86_64.tar.gz
sudo mv /opt/nexus-3.82.0-08 /opt/nexus
sudo rm -rf nexus-3.82.0-08-linux-x86_64.tar.gz
```

## Grant permissions for nexus user to start and manage nexus service
```sh
# Change the owner and group permissions to /opt/nexus and /opt/sonatype-work directories.
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chmod -R 775 /opt/nexus
sudo chmod -R 775 /opt/sonatype-work
```
##  Open /opt/nexus/bin/nexus.rc file and  uncomment run_as_user parameter and set as nexus user.
## # change from #run_as_user="" to [ run_as_user="nexus" ]

```sh
echo  'run_as_user="nexus" ' > /opt/nexus/bin/nexus.rc
```

##  CONFIGURE NEXUS TO RUN AS A SERVICE 
```sh

cd /etc/systemd/system/
sudo vi nexus.service

#input thes content below into the nexus.service file

[Unit]
Description=nexus service
After=network.target
  
[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop

User=nexus
Restart=on-abort
TimeoutSec=600
  
[Install]
WantedBy=multi-user.target

```
### Activate the service with the following commands:
```sh

sudo systemctl daemon-reload
sudo systemctl enable nexus.service
sudo systemctl start nexus.service
sudo systemctl status nexus.service
```
#### Ensure that Nexus is running and access nexus in the browser   
Nexus default port is = `8081` get the Nexus public ip address `publicIP:8081` 

Once your instance is up and running, Log in to http://localhost:8080 get initial password :
Default credentials are: admin / admin123


------------------
references
1.  https://stackoverflow.com/questions/55111719/installing-nexus-error-the-version-of-the-jvm-must-be-at-least-1-8-and-at-most
2. https://help.sonatype.com/en/download.html
3. https://help.sonatype.com/en/run-as-a-service.html
