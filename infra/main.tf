terraform {
  required_version = ">= 0.13.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.19.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_net_mask = var.vpc_net_mask
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  route_table_id = module.vpc.route_table_id
  vpc_net_mask = var.vpc_net_mask
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  name = "isucon_security_group"
  cidr_blocks = split(",", var.access_cidr_blocks)
}

module "participant-ec2" {
  source = "./modules/ec2"
  standalone_ami_id = var.standalone_ami_id
  subnet_id = module.subnet.subnet_id
  security_group_id = module.security_group.security_group_id
  ec2_members = var.ec2_members
  ec2_instance_type = var.ec2_instance_type
  ec2_volume_size = var.ec2_volume_size
}

