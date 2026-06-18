region                 = "us-east-1"
cluster_name           = "{{name}}-staging"
k8s_version            = "{{k8s_version}}"
instance_type          = "t3.large"
desired_size           = 2
min_size               = 2
max_size               = 4
single_nat_gateway     = true
endpoint_public_access = true
# Grant your AWS console user/role cluster-admin (run: aws sts get-caller-identity):
# admin_principal_arns = ["arn:aws:iam::<account-id>:user/<your-user>"]
tags = {
  Environment = "staging"
  ManagedBy   = "DevOpsAgent"
}
