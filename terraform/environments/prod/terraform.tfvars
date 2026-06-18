region                 = "us-east-1"
cluster_name           = "{{name}}-prod"
k8s_version            = "{{k8s_version}}"
instance_type          = "m5.large"
desired_size           = 3
min_size               = 3
max_size               = 6
single_nat_gateway     = false
endpoint_public_access = true
# Grant your AWS console user/role cluster-admin (run: aws sts get-caller-identity):
# admin_principal_arns = ["arn:aws:iam::<account-id>:user/<your-user>"]
tags = {
  Environment = "prod"
  ManagedBy   = "DevOpsAgent"
}
