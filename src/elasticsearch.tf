module "elasticsearch_demo" {
    source = "./main"
    cluster-vpc-id = "vpc-150f1c70"
    cluster-subnets = ["subnet-c23dd49a","subnet-c23dd49a"]
    node-count = 1
    ec2_key_name = "admin_key"
    elastic-password = "dGVzdDEyMzQ1Ng=="
}
