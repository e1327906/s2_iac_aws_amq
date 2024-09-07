provider "aws" {
  region = "ap-southeast-1"
}

# Data source to get existing VPC
data "aws_vpc" "existing" {
  id = var.vpc_id
}

# Data source to get existing subnets in the VPC
data "aws_subnets" "existing" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.existing.id]
  }
}

# Create a new security group for the MQ broker
resource "aws_security_group" "mq_security_group" {
  vpc_id = data.aws_vpc.existing.id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 61616 # Default port for ActiveMQ
    to_port     = 61616
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 61617 # OpenWire port
    to_port     = 61617
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 8161 # Web admin console port
    to_port     = 8161
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "mq-security-group"
  }
}

# Create an Amazon MQ Broker (ActiveMQ) with single instance deployment
resource "aws_mq_broker" "example" {
  broker_name         = var.broker_name
  engine_type          = "ACTIVEMQ"
  engine_version       = var.engine_version
  host_instance_type   = var.instance_type
  security_groups      = [aws_security_group.mq_security_group.id]  
  subnet_ids           = [data.aws_subnets.existing.ids[0]]
  publicly_accessible  = true  # Set to false to make it accessible only within the VPC
  deployment_mode      = "SINGLE_INSTANCE" # Set to SINGLE_INSTANCE for single instance deployment
  authentication_strategy = "SIMPLE"
  
  maintenance_window_start_time {
    day_of_week = var.maintenance_day
    time_of_day  = var.maintenance_time
    time_zone   = var.maintenance_timezone
  }
  
  logs {
    general = true
  }

  user {
    username = var.mq_username
    password = var.mq_password
  }

  tags = {
    Name = var.broker_name
  }
}
