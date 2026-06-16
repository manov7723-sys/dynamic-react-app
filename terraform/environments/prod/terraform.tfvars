region                 = "us-east-1"
cluster_name           = "my-eks-cluster-prod"
k8s_version            = "1.30"
instance_type          = "m5.large"
desired_size           = 3
min_size               = 3
max_size               = 6
single_nat_gateway     = false
endpoint_public_access = true
tags = {
  Environment = "prod"
  ManagedBy   = "DevOpsAgent"
}
