variable "aws_access_key" {
  description = "The AWS access key."
}

variable "aws_secret_key" {
  description = "The AWS secret key."
}

variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-west-1"
}

variable "vpc_subnet_ids" {
  description = "Set of VPC Subnets that the ECS autoscaling group may launch new ECS nodes in."
  default     = ""
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default     = "default"
}

/* ECS optimized AMIs per region */
variable "amis" {
  default = {
    ap-northeast-1 = "ami-8aa61c8a"
    ap-southeast-2 = "ami-5ddc9f67"
    eu-west-1      = "ami-2aaef35d"
    us-east-1      = "ami-b540eade"
    us-west-1      = "ami-5721df13"
    us-west-2      = "ami-cb584dfb"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ec2_key_pair_name" {
  description = "Name of the aws ssh key pair on the ECS cluster instances"
}

variable "vpc_id" {
  description = "ID of the VPC where ECS instances will reside"
}


variable "min_num_instances" {
  description = "The minimum number of instances in the ECS cluster's auto-scaling group"
  default = 1
}

variable "max_num_instances" {
  description = "The maximum number of instances in the ECS cluster's auto-scaling group"
  default = 10
}

variable "desired_num_instances" {
  description = "The desired number of instances in the ECS cluster's auto-scaling group"
  default = 1
}
