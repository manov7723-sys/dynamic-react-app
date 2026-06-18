region                 = "us-east-1"
cluster_name           = "staging-cluster-dev"
k8s_version            = "1.30"
instance_type          = "t3.medium"
desired_size           = 2
min_size               = 1
max_size               = 3
node_disk_size         = 50
single_nat_gateway     = true
endpoint_public_access = true

# Networking — create a new VPC (create_vpc=true) or use an existing one (create_vpc=false).
create_vpc       = false
subnet_count     = 2
node_subnet_type = "private"
# Used only when create_vpc=false (comma-separated subnet IDs):
existing_subnet_ids      = ""
existing_node_subnet_ids = ""

# Restrict who can reach the public API endpoint (default: open to the world).
# Lock this to your office/VPN egress IP for production, e.g. ["203.0.113.4/32"].
public_access_cidrs = ["0.0.0.0/0"]
# Grant your AWS console user/role cluster-admin (run: aws sts get-caller-identity):
# admin_principal_arns = ["arn:aws:iam::<account-id>:user/<your-user>"]
tags = {
  Environment = "dev"
  ManagedBy   = "DevOpsAgent"
}
