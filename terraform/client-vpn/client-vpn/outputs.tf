output "client_vpn_endpoint_id" {
  value       = aws_ec2_client_vpn_endpoint.this.id
  description = "Client VPN endpoint ID"
}

output "client_vpn_security_group_id" {
  value       = aws_security_group.vpn.id
  description = "SG attached to the Client VPN endpoint. Add this as an ingress source on your RDS/EC2 SGs to let VPN clients reach them (safer than CIDR-based rules)."
}

output "client_vpn_dns_name" {
  value       = aws_ec2_client_vpn_endpoint.this.dns_name
  description = "DNS name clients connect to (part of the .ovpn config)"
}

output "download_config_command" {
  value       = "aws ec2 export-client-vpn-client-configuration --client-vpn-endpoint-id ${aws_ec2_client_vpn_endpoint.this.id} --region us-east-1 --output text > client.ovpn"
  description = "Command to download the .ovpn config — then append the client_certificate_pem / client_private_key_pem outputs into it"
}

output "region" {
  value       = "us-east-1"
  description = "Region the Client VPN lives in"
}

output "client_certificate_pem" {
  value       = tls_locally_signed_cert.client.cert_pem
  description = "Client cert PEM — paste between <cert></cert> tags in the .ovpn file"
  sensitive   = true
}

output "client_private_key_pem" {
  value       = tls_private_key.client.private_key_pem_pkcs8
  description = "Client private key PEM — paste between <key></key> tags in the .ovpn file"
  sensitive   = true
}

output "ca_certificate_pem" {
  value       = tls_self_signed_cert.ca.cert_pem
  description = "CA cert PEM — paste between <ca></ca> tags in the .ovpn file"
}
