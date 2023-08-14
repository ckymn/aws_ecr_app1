resource "aws_ecr_repository" "devops_case" {
  name                 = "devops-case"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    "env" = "demo"
  }
}
