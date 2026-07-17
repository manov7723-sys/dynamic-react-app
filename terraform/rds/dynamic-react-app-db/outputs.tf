output "endpoint" {
  value       = aws_db_instance.rds.endpoint
  description = "host:port for the RDS instance"
}

output "host" {
  value       = aws_db_instance.rds.address
  description = "Hostname only (no port)"
}

output "port" {
  value       = 5432
  description = "Listener port"
}

output "database" {
  value       = "dynamic_react_app_db"
  description = "Initial database name created on first boot"
}

output "username" {
  value       = "app"
  description = "Master username"
}

output "password" {
  value       = random_password.db.result
  sensitive   = true
  description = "Master password  pipe into a Kubernetes Secret; never log this."
}

output "connection_string" {
  value       = "postgres://app:${urlencode(random_password.db.result)}@${aws_db_instance.rds.address}:5432/dynamic_react_app_db"
  sensitive   = true
  description = "Ready-to-use DATABASE_URL for the app pods"
}

output "security_group_id" {
  value       = aws_security_group.rds.id
  description = "RDS SG  inbound from the EKS worker SG"
}
