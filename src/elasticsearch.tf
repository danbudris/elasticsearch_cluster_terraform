module "elasticsearch_demo" {
    source = "./main"
    cluster-vpc-id = ""
    cluster-subnets = ["",""]
    node-count = 1
    ec2_key_name = "admin_key"
    elastic-password = ""
}
