# Definición de la primera VPC
module "networking" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"

  name                    = "vpc-${var.project}-${var.env}"
  cidr                    = var.vpcs["main_vpc"].cidr
  azs                     = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnets          = var.vpcs["main_vpc"].public_subnets
  enable_dns_hostnames    = true
  enable_dns_support      = true
  map_public_ip_on_launch = true
  public_subnet_tags = {
    subnet-tag = "public-subnet-${var.project}-1"
  }
}