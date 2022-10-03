provider "aws" {
  region = "eu-west-3"
  access_key = "AKIARAIGE77IW7AVZ6ZO"
  secret_key = "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"
}
terraform {
  required_version = ">= 0.13.1"
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 3.36.0"
    }
  }
}

resource "aws_security_group" "worker_group_mget_one" {
  name_prefix = "worker_group_mget_one"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"

    cidr_blocks = [
      "10.0.0.0/8"
    ]
  }
}
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "test-vpc"
  cidr = "10.0.0.0/16"
  azs =  ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
}
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"
  cluster_name = var.cluster_name
  cluster_version = "1.22"
  subnet_ids = module.vpc.private_subnets
  cluster_endpoint_private_access = true
  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    green = {
      min_size     = 1
      max_size     = 2
      desired_size = 1

      instance_types = ["t2.small"]
      capacity_type  = "SPOT"
    }
  }


  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::069269258193:user/Joel"
      username = "Joel"
      groups   = ["system:masters"]
    },
  ]


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
    
    
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token = data.aws_eks_cluster_auth.cluster.token
}
resource "kubernetes_deployment" "superman-deploy" {
  metadata {
    name = "superman"
    labels = {
      test = "superman"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "superman-pod"
      }
    }

    template {
      metadata {
        labels = {
          test = "superman-pod"
        }
      }

      spec {
        container {
          image = "joelyoung/super"
          name  = "example"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "superman-svc" {
  metadata {
    name = "superman"
  }
  spec {
    port {
      port        = 8080
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
