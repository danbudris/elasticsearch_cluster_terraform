## To DO:
# encrypted communication
# ec2 discovery plugin -- add to user data
# https://www.elastic.co/guide/en/elasticsearch/plugins/current/_settings.html
# might be easier to set up instance tags and user instance tag filters to get the cluster members
# https://github.com/floragunncom/search-guard/
# SearchGuard (above) looks like a great place to start in terms of building out a secured elastic stack..

# Let's set up the user data for each node in the cluster, using a template file
data "template_file" "cloud-init" {
  template              = "${file("${path.module}/cloud_init.tpl")}"
  count                 = "${var.node-count}"
  vars {
    cluster-name        = "${var.cluster-name}"
    cluster-environment = "${var.cluster-environment}"
    node-count          = "${count.index}"
  }
}

# Instance Security Group, allowing node-to-node communication
resource "aws_security_group" "elastic-intra-cluster" {
  name          = "${var.cluster-name}-inter-node-sg"
  description   = "Allow traffic between individual nodes of the cluster"
  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    self        = true
  }
  tags {
    Name = "${var.cluster-name}-${var.cluster-environment}-inter-node-sg"
  }
}

# Elastic Instances
# Get a prebaked Ubuntu AMI from AWS
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Create elastic search instances
resource "aws_instance" "elastic-cluster" {
  count                  = "${var.node-count}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.node-instance-type}"
  user_data              = "${element(template_file.cloud-init.*.rendered, count.index)}"
  subnet_id              = "${element(var.cluster-subnets, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.elastic-intra-cluster.id}"]

  tags {
    Name = "${var.cluster-name}-${var.cluster-environment}-${count.index}"
  }
}