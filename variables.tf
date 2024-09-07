variable "vpc_id" {
  description = "The ID of the existing VPC"
  type        = string
  default     = "vpc-0c229f5efeea9aea5"
}

#variable "subnet_ids" {
  #description = "List of subnet IDs in the VPC"
  #type        = list(string)
#}

#variable "security_group_id" {
  #description = "The ID of the existing security group"
  #type        = string
#}

variable "broker_name" {
  description = "The name of the Amazon MQ broker"
  type        = string
  default     = "aws_amq_demo"
}

variable "engine_version" {
  description = "The version of the ActiveMQ engine"
  type        = string
  default     = "5.16.7"
}

variable "instance_type" {
  description = "The instance type for the ActiveMQ broker"
  type        = string
  default     = "mq.t3.micro"
}

variable "maintenance_day" {
  description = "The day of the week for maintenance"
  type        = string
  default     = "SATURDAY"
}

variable "maintenance_time" {
  description = "The time of day for maintenance"
  type        = string
  default     = "03:00"
}

variable "maintenance_timezone" {
  description = "The timezone for the maintenance window"
  type        = string
  default     = "UTC"
}

variable "mq_username" {
  description = "The username for the ActiveMQ broker"
  type        = string
  default     = "amq_user"
}

variable "mq_password" {
  description = "The password for the ActiveMQ broker"
  type        = string
  default     = "P@ssw0rd112233445566"
}