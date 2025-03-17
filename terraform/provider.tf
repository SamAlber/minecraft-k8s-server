terraform { # Best Practice! 
  required_version = "1.9.8"
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Specify the source for the AWS provider
      version = ">= 5.27.0"      # Use a stable version of the AWS provider
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.35.1"
    }
  }
}

# required_providers objects can only contain "version", "source" and "configuration_aliases" attributes. To configure a provider, use a "provider" block.

provider "aws" {
  region = var.aws_region # AWS provider configuration
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

# Add iamadmin to the aws-auth ConfigMap
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapUsers = jsonencode([
      {
        userarn  = "arn:aws:iam::761018880324:user/iamadmin" # Replace with the correct ARN
        username = "iamadmin"
        groups   = ["system:masters"]
      }
    ])
  }

  depends_on = [module.eks]
}


