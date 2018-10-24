# Instance User Data Template
# Download Elastic Search and untar it
cd /opt && \
curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.4.2.tar.gz && \
tar -xvf elasticsearch-6.4.2.tar.gz

# Install Elastic Search, setting the cluster and node name based on the environment and given cluster name
/opt/elasticsearch-6.4.2/bin/elasticsearch -Ecluster.name=${var.cluster-name}-${var.environment} -Enode.name=${var.cluster-name}-${var.environment}-${var.node-count}