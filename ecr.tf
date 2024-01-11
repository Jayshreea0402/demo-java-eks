resource "aws_ecr_repository" "image" {
  name                 = "terraform_repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

output "ecr_repository_arn" {
  value = aws_ecr_repository.image.arn
}




