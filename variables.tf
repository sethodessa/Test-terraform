variable "region" {
  type    = string
  default = "us-east-1"
}

variable "profile" {
  default = "awsaml-230466894455-BAHSSO_Admin_Role"
}

variable "ami" {
  type    = string
  default = "ami-087c17d1fe0178315"
}

variable "instance_type" {
  type    = string
  default = "m5.large"
}

variable "key_name" {
  type    = string
  default = "TableauTest"
}

variable "subnet_id" {
  type    = string
  default = "subnet-04cc0fd07f7353301"
}

variable "volume_size" {
  type    = number
  default = 50

}

variable "iam_instance_profile" {
  type    = string
  default = "ecsInstanceRole"
}

variable "availability_zone" {
  type    = string
  default = "us-east-1a"
}

variable "vpc_security_group_ids" {
  type = list(string)
  default = ["sg-0d07714825ce7e016",
    "sg-0263ba26858e9d806"]
}

variable "user_data" {
  type    = string
  default = "./user_data.sh"
}

variable "ecs_instance_a_name" {
  type    = string
  default = "Apache-Test-Seth1"
}

variable "ecs_instance_b_name" {
  type    = string
  default = "Apache-Test-Seth2"
}

variable "alb_name" {
  type = string
  default = "seth-test-terraform"
}

variable "vpc_id" {
  type = string
  default = "vpc-04a8affd62032554f"
}

variable "environment" {
  type = string
  default = "seth-test-terraform"
}

variable "asg_group_id" {
  type = string
  default = "test-terraform-asg-seth"
}

variable = "cust_ipv4_pool" {
  type = string
  default = "ipv4pool-coip-0e9cb72f8cabad56a"
}

variable "tg_port" {
  type = string
  default = "80"
}

variable "protocol" {
  type = string
  default = "HTTP"
}

