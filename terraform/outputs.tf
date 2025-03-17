output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
  description = "EKS cluster API endpoint"
}

output "cluster_name" {
  value = var.cluster_name
  description = "EKS cluster name"
}

# Outputs the cluster endpoint and name for use with kubectl.

