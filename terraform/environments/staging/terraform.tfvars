region                 = "us-east-1"
cluster_name           = "my-eks-cluster-staging"
k8s_version            = "1.30"
instance_type          = "t3.large"
desired_size           = 2
min_size               = 2
max_size               = 4
single_nat_gateway     = true
endpoint_public_access = true
tags = {
  Environment = "staging"
  ManagedBy   = "DevOpsAgent"
}
