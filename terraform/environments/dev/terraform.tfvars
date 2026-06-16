region                 = "us-east-1"
cluster_name           = "my-eks-cluster-dev"
k8s_version            = "1.30"
instance_type          = "t3.medium"
desired_size           = 2
min_size               = 1
max_size               = 3
single_nat_gateway     = true
endpoint_public_access = true
tags = {
  Environment = "dev"
  ManagedBy   = "DevOpsAgent"
}
