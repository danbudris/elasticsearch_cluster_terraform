module "elasticsearch_module_demo" {
    source = "./main"
    cluster-name = "demoCluster"
    cluster-environment = "dev"
    node-count = 1
    cluster-vpc-id = ""
    cluster-subnets = [""]
}