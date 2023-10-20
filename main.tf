provider "aws" {
  region = "us-west-2"  # Change to your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "my_subnet" {
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"  # Adjust AZs as needed
}

resource "aws_iam_role" "eks_service_role" {
  name = "eks-service-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_service_role.arn

  vpc_config {
    subnet_ids = aws_subnet.my_subnet[*].id
  }
}

resource "aws_security_group" "eks_worker_sg" {
  name_prefix = "eks_worker_sg-"
  description = "Security group for EKS worker nodes"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"

  node_group_status = "ACTIVE"
  desired_size     = 2
  max_size         = 3
  min_size         = 1

  instance_types = ["t2.micro"]

  remote_access {
    ec2_ssh_key = "my-ssh-key"
  }

  launch_template {
    id      = "lt-xxxxxxxxxxxxxxxxx"
    version = "$Default"
  }

  capacity_type = "ON_DEMAND"
}
