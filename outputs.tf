output "broker_id" {
  description = "The ID of the Amazon MQ broker"
  value       = aws_mq_broker.example.id
}

output "broker_endpoint" {
  description = "The endpoint of the Amazon MQ broker"
  value       = aws_mq_broker.example.broker_instances[0].endpoint
}