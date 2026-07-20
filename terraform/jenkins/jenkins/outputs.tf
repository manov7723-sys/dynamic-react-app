output "jenkins_url" {
  value       = "http://${aws_instance.this.public_ip}:8080"
  description = "Open this in a browser once the instance status checks pass — Jenkins takes ~2 min after boot to accept connections."
}

output "jenkins_public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP of the Jenkins VM"
}

output "jenkins_admin_username" {
  value       = "admin"
  description = "Log in with this username + the password you set at wizard time"
}

output "jenkins_admin_password" {
  value       = "admin123"
  description = "Initial admin password — rotate it from Manage Jenkins → Users at first login (currently visible in EC2 user-data metadata)."
  sensitive   = true
}

output "shell_command" {
  value       = "ssh -i ~/.ssh/hari.pem ec2-user@${aws_instance.this.public_ip}"
  description = "SSH is open (per SG) using key pair 'hari'. Use the .pem you downloaded when creating that key pair in the EC2 console."
}

output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 instance id — pass to 'aws ssm start-session --target <id>' for shell access without SSH."
}

output "region" {
  value       = "us-east-1"
  description = "Region the VM lives in"
}
