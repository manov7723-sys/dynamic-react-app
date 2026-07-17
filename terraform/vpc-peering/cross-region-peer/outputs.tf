output "peering_connection_id" {
  value       = aws_vpc_peering_connection.this.id
  description = "The VPC peering connection id"
}

output "peering_status" {
  value       = aws_vpc_peering_connection_accepter.this.accept_status
  description = "Should read 'active' once the apply finishes"
}

output "left_summary" {
  value       = "vpc-0458a23d9cb5dfece in us-east-1 (10.0.0.0/16)"
  description = "Requester VPC"
}

output "right_summary" {
  value       = "vpc-0710340ffd7174a26 in us-east-2 (172.31.0.0/16)"
  description = "Accepter VPC"
}

output "verify_command" {
  value       = "aws ec2 describe-vpc-peering-connections --vpc-peering-connection-ids ${aws_vpc_peering_connection.this.id} --region us-east-1"
  description = "One-line CLI to confirm status outside of Terraform"
}
