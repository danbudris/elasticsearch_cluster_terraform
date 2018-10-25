#! /bin/bash
# Instance User Data Template
# Install Java
apt-get update -y
apt install default-jre -y

# Download Elastic Search and untar it
cd /opt && curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.2.tar.gz && tar -xvf elasticsearch-6.4.2.tar.gz

# Let 'ubuntu' user take ownership of java and elasticsearch
chown ubuntu -R /opt/elasticsearch-6.4.2
chown ubuntu -R /usr/bin/java

#Elastic Search as a daemon, recording the processes ID, setting the cluster and node name based on the environment and given cluster name, and start the cluster as ubuntu
su ubuntu -c '/opt/elasticsearch-6.4.2/bin/elasticsearch -d -p pid -Ecluster.name=${cluster-name}-${environment} -Enode.name=${cluster-name}-${environment}-${node-count}'
su ubuntu -c '/opt/elasticsearch-6.4.2/bin/elasticsearch-users useradd ${elastic-user} -p ${elastic-password}'