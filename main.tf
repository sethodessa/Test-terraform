provider "aws" {
  region = var.region
  profile = var.profile
}

resource "aws_alb_target_group" "test-terraform-seth" {
  name                 = var.alb_name
  port                 = va.tg_port
  protocol             = var.protocol
  vpc_id               = var.vpc_id
 
  health_check {
    port = var.tg_port
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"  # has to be HTTP 200 or fails
  }

  tags = {
    Environment = var.environment
  } 
}

# Create a new load balancer
resource "aws_lb" "app_load_balancer" {
name = var.alb_name
internal = false
security_groups = var.vpc_security_group_ids
subnets = [ var.subnet_id ]
customer_owned_ipv4_pool = var.cust_ipv4_pool
}


resource "aws_lb_listener" "mylistener" {
  load_balancer_arn = "${aws_lb.app_load_balancer.arn}"
  port              = var.tg_port
  protocol          = var.protocol

  default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.test-terraform-seth.arn}"
  }
}


resource "aws_launch_configuration" "web" {
  name_prefix = "web-"
  image_id      = var.ami
  instance_type = var.instance_type
  iam_instance_profile   = var.iam_instance_profile
  user_data              = file(var.user_data)
  security_groups =  var.vpc_security_group_ids
  key_name               = var.key_name
  lifecycle {
    create_before_destroy = true
  }
}

# Create an ASG that ties all of this together
resource "aws_autoscaling_group" "my-alb-asg" {
  name = var.asg_group_id
  desired_capacity = "2"
  min_size = "2"
  max_size = "3"
  health_check_grace_period = "5"
  termination_policies = [
    "OldestInstance",
    "OldestLaunchConfiguration",
  ]

  health_check_type = "EC2"
  target_group_arns =  [aws_alb_target_group.test-terraform-seth.arn
  ]

  launch_configuration =aws_launch_configuration.web.name

  vpc_zone_identifier  = [
    var.subnet_id
  ]

  lifecycle {
    create_before_destroy = true
  }
}