 output "ecs_service_url" {
  value = aws_ecs_service.kuma_service.id
}
