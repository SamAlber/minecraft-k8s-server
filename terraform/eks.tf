module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"   # Using the latest version for up-to-date features

  cluster_name    = var.cluster_name
  cluster_version = "1.31"  # Specify the desired Kubernetes version

  cluster_endpoint_public_access = true

  # Managed Node Groups Configuration
  eks_managed_node_groups = {
    # On-Demand Node Group for critical workloads
    on_demand = {
      node_group_name = "on-demand-nodes"
      instance_types  = ["t3.medium"]  # Balanced instance type for general-purpose workloads

      scaling_config = {
        desired_size = 2  # Maintain two instances for high availability
        min_size     = 1  # Allow scaling down to one instance
        max_size     = 3  # Allow scaling up to three instances
      }

      capacity_type = "ON_DEMAND"  # Ensures consistent performance without interruptions

      # Additional settings
      ami_type  = "AL2_x86_64"  # Amazon Linux 2
      disk_size = 20            # Root disk size in GB
    }

    # Spot Node Group for cost-effective, interruptible workloads
    spot = {
      node_group_name = "spot-nodes"
      instance_types  = ["t3.medium", "t3a.medium", "t2.medium"]  # Multiple types to increase the chances of Spot availability.

      scaling_config = {
        desired_size = 2  # Start with two instances
        min_size     = 0  # Allow scaling down to zero
        max_size     = 5  # Allow scaling up to five instances
      }

      capacity_type = "SPOT"  # Utilize Spot Instances for cost savings

      # Additional settings
      ami_type  = "AL2_x86_64"  # Amazon Linux 2
      disk_size = 20            # Root disk size in GB

      # Taints to prefer scheduling critical pods on On-Demand nodes
      taints = [{
        key    = "spotInstance"
        value  = "true"
        effect = "PREFER_NO_SCHEDULE"
      }]

      # Labels to identify Spot nodes
      labels = {
        lifecycle = "spot"
      }
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # These private subnets are typically used for EKS worker nodes to ensure they are not publicly accessible.

  tags = {
    Environment = "development"
    Project     = "minecraft-server"
  }
}

/*
Why Not Other Options?

Self-Managed Nodes: While they offer complete control over node configuration, they require manual management of updates and scaling, increasing operational complexity. 
AWS DOCUMENTATION

AWS Fargate: Provides serverless compute for containers but may not be suitable for stateful applications like a Minecraft server, which require persistent storage and specific performance characteristics.
*/
