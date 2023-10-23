variable "standalone_ami_id" {
  type = string
  default = "ami-03bbe60df80bdccc0"
  description = "AMI name to use for standalone instances"
}

variable "vpc_net_mask" {
  type = string
  default = "10.1.0.0"
  description = "VPC network subnet mask"
}

variable "access_cidr_blocks" {
  type = string
  default = "0.0.0.0/0"
  description = "CIDR blocks to allow access to" 
}

variable "ec2_members" {
  type = map
  default = { # デフォルトではベンチマーカー役も含んだ4台のEC2が同じAMIで構築される
    "0" = "worker-01"
    "1" = "worker-02"
    "2" = "worker-03"
    "3" = "benchmark-instance"
  }
  description = "EC2 instances for isucon practice"
}

variable "ec2_instance_type" {
  type        = string
  default = "t2.small"
  description = "EC2 instance type"
}

variable "ec2_volume_size" {
  type        = number
  default     = 20
  description = "EC2 EBS volume size"
}
