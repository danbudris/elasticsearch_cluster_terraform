variable "cluster-name" {
    default     = "elastic"
    description = "The base name of the cluster.  Will be used to construct node and security group names, as well as naming the cluster"
}

variable "cluster-environment" {
    default     = "dev"
    description = "The base environment (i.e. Prod, QA, Stage, etc) of the cluster.  Will be used to constcut node and security group names, as well as naming the cluster"
}

variable "node-instance-type" {
    default     = "m4.large"
    description = "An AWS instance type for the cluster nodes."
}

variable "node-count" {
    default     = 3
    description = "The number of nodes to create in the cluster."
}

variable "cluster-vpc-id" {
    description = "The AWS VPC ID for the VPC that the cluster will reside in"
}

variable "cluster-subnets" {
    type        = "list"
    description = "A list of subnet IDs to place the cluster nodes in.  If the list is shorter than the number of nodes, Terraform iterates over the list from the start, and will place multiple nodes in the same subnets."
}

variable "ec2_key_name" {
    type        = "string"
    description = "The name of the AWS ec2 keypair to use for accessing the instance"
}

variable "elastic-user" {
    type        = "string"
    description = "A username to use as the base user created at the time elasticsearch is started"
    default     = "elastic"
}

variable "elastic-password" {
    type        = "string"
    description = "A base64 encoded password to use as the basic password for elasticsearch"
}