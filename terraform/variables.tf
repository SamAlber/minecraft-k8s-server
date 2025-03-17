variable "aws_region" {
  default     = "us-east-1"
  description = "AWS region for deployment"
}

variable "cluster_name" {
  default     = "minecraft-cluster"
  description = "Name of the EKS cluster"
}

variable "node_instance_type" {
  default     = "t3.medium"
  description = "Instance type for worker nodes"
}

variable "spot_price" {
  default     = "0.03"
  description = "Maximum spot price for spot instances"
}


