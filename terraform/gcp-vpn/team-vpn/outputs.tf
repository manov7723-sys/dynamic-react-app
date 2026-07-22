output "client_vpn_endpoint_id" {
  value       = google_compute_instance.vpn.id
  description = "GCE instance id serving as the OpenVPN endpoint"
}

output "client_vpn_dns_name" {
  value       = google_compute_address.vpn.address
  description = "Static public IP (or DNS name) clients connect to — goes into the .ovpn 'remote' line"
}

output "region" {
  value       = "us-west1"
  description = "Region the endpoint lives in"
}

output "vpn_port" {
  value       = 1194
  description = "Port clients connect on"
}

output "vpn_transport" {
  value       = "udp"
  description = "Transport protocol (udp/tcp)"
}

output "client_certificate_pem" {
  value       = tls_locally_signed_cert.client.cert_pem
  description = "Initial client cert PEM — paste between <cert></cert> in the .ovpn file"
  sensitive   = true
}

output "client_private_key_pem" {
  value       = tls_private_key.client.private_key_pem_pkcs8
  description = "Initial client private key PEM — paste between <key></key> in the .ovpn file"
  sensitive   = true
}

output "ca_certificate_pem" {
  value       = tls_self_signed_cert.ca.cert_pem
  description = "CA cert PEM — paste between <ca></ca> in the .ovpn file"
}

output "ca_private_key_pem" {
  value       = tls_private_key.ca.private_key_pem
  description = "CA private key PEM. SENSITIVE — used by the app's issue-user-cert flow to mint per-user certs off this CA without re-running Terraform."
  sensitive   = true
}
