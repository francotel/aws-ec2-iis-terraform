tf_version = "1.9.3"
env        = "demo"
project    = "iis-tf"
owner      = "franco.navarro"
cost       = "0001-iis-demo"

####   VARIABLES VPC   ####

vpcs = {
  main_vpc = {
    cidr           = "172.16.0.0/16"
    public_subnets = ["172.16.2.0/24"]
  }
}