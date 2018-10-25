# elasticsearch_cluster_terraform
Terraform module for building an Elasticsearch cluster on AWS.

## Quick Start
### Setup
- Download the latest version of <a href="https://www.terraform.io/downloads.html">Terraform</a> for your platform, and <a href="https://askubuntu.com/questions/653033/add-executable-to-path?rq=1">add it to your path</a>.  Check that you can execute `terraform` from the command line.
- Set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables; these are an AWS Access Key and AWS Secret Key which have access to create EC2 Instances, create Security Groups, and read/lookup AMIs. When you run `terraform` commands it will read these environment variables first and use them to authenticate to your AWS account. While configuring a <a href="https://www.terraform.io/docs/providers/aws/">`terraform provider`</a> is beyond the scope of this readme I will note that there are numerous ways to pass credentials to Terraform.  The prefered manner is  executing the commands on an EC2 instance with an IAM instance profile granted the proper permissions.  For local access, you can use environment variables or add paramaters (`acces_key` and `secret_key`) to `provider.aws` in `./provider.tf`, and pass the access_key and secret_key as variables at runtime.  I perfer temporarily setting environment variables

### Module Reference Configuration -- 3 Node Cluster, 'elastic-dev', of m4.larges
1 Choose a VPC for your Elasticsearch Cluster, and add the VPC ID to the `cluster-vpc-id` paramater of `module.elasticsearch_demo` in `./elasticsearch.tf`. This module creates a security group in this VPC.

2 Choose three subnets for your Elasticsearch Cluster, and add them as a list (e.g. `"["subnetid-123213","subnetid-123446","subnetid-124515]"`) to the `cluster-subnets` parameter of `module.elasticsearch_demo` in `./elasticsearch.tf`.  This module will spread nodes across these subnets.  I reccomend choosing subnets in 3 seperate AWS Availability Zones to enhance resiliance.  

3 Run a `terraform plan` to check the viability of your configuration.  Either execute this plan from  

## Paramaters
#### See `./main/inputs.tf` for all input paramaters and their defualts.
#### Required Paramaters:
- `cluster-vpc-id`
- `cluster-subnets`
- `ec2_key_name`
- `elastic-password`
    - A base64 encoded string; decoded string to be used as a password for `elastic-user`.  Defaults to base64 encode of "ATestPasswordForThisProject"

#### Optional Paramaters:
- `cluster-name`
    - A name for the cluster; used in resource naming, and combined with `cluster-environment` for the final cluster name.  Defaults to "elsatic"
- `cluster-environment`
    - An environment for the cluster; used in resource naming.  Defaults to "dev"
- `node-instance-type`
    - AWS Instnace Type for the nodes.  Defaults to `m4.large`.
- `node-count`
    - Number of nodes in the cluster.  Defaults to 3.
- `elastic-user`
   - A string, setting a username for elastic.  Defaults to "elastic"