output "server_certificate_arn" {
  value       = aws_acm_certificate.server.arn
  description = "Paste this into 'Server certificate ARN' when creating a Client VPN endpoint in Manual cert mode."
}

output "client_ca_certificate_arn" {
  value       = aws_acm_certificate.client_ca.arn
  description = "Paste this into 'Client root CA ARN' when creating a Client VPN endpoint in Manual cert mode. The endpoint accepts any client cert signed by this CA."
}

output "ca_certificate_pem" {
  value       = tls_self_signed_cert.ca.cert_pem
  description = "CA cert PEM — paste between <ca></ca> in the .ovpn file."
}

output "region" {
  value       = "us-east-1"
  description = "ACM region — must match the Client VPN endpoint's region."
}

output "client_certificate_count" {
  value       = 1
  description = "Number of client certs issued."
}

output "client_0_common_name" {
  value       = "vasanth"
  description = "CN of client cert #1 — shows in AWS Connection Log."
}

output "client_0_certificate_pem" {
  value       = tls_locally_signed_cert.client_0.cert_pem
  description = "PEM of client cert #1 (vasanth). Hand this + key + ca_certificate_pem to the person using it."
  sensitive   = true
}

output "client_0_private_key_pem" {
  value       = tls_private_key.client_0.private_key_pem_pkcs8
  description = "Private key of client cert #1 (vasanth). Sensitive — never print in chat."
  sensitive   = true
}
