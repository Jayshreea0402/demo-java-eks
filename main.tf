# Define the AWS provider
provider "aws" {
  region = "us-west-2"  # Set your desired AWS region
}

# Create a VPC
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"  # Specify your desired VPC CIDR range
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "eks-vpc"
  }
}

# Create subnets for the EKS cluster
resource "aws_subnet" "eks_subnet" {
  count = 3
  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = element(["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"], count.index)
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)
  map_public_ip_on_launch = true
}

# Create an Internet Gateway for the VPC
resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
}

# Attach the Internet Gateway to the VPC
resource "aws_vpc_attachment" "eks_igw_attachment" {
  vpc_id = aws_vpc.eks_vpc.id
  internet_gateway_id = aws_internet_gateway.eks_igw.id
}

# Create a security group for the EKS cluster
resource "aws_security_group" "eks_sg" {
  name_prefix = "eks-"
  vpc_id = aws_vpc.eks_vpc.id
}

# Allow inbound traffic to the EKS nodes (customize rules as needed)
resource "aws_security_group_rule" "eks_sg_ingress" {
  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.eks_sg.id
}

# Create an EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.21"  # Specify your desired Kubernetes version
  subnets         = aws_subnet.eks_subnet[*].id
  vpc_id          = aws_vpc.eks_vpc.id
  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t2.micro"  # Specify your desired instance type
      key_name      = "my-key-pair"  # Specify your SSH key pair
    }
  }
}

# Output the EKS cluster endpoint
output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
