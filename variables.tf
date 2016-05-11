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
    /* amzn-ami-2016.03.b-amazon-ecs-optimized */
    us-east-1      = "ami-a1fa1acc"
    us-west-1      = "ami-68106908"
    us-west-2      = "ami-a28476c2"
    eu-west-1      = "ami-f66de585"
    eu-central-1   = "ami-1c769473"
    ap-northeast-1 = "ami-a98d97c7"
    ap-southeast-1 = "ami-4b3ee928"
    ap-southeast-2 = "ami-513c1032"
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
  default     = 1
}

variable "max_num_instances" {
  description = "The maximum number of instances in the ECS cluster's auto-scaling group"
  default     = 10
}

variable "desired_num_instances" {
  description = "The desired number of instances in the ECS cluster's auto-scaling group"
  default     = 1
}

variable "security_group_ids" {
  description = "Set of security groups ECS instances will be in when launched by auto-scaling group"
}
