resource "aws_ecr_repository" "foo" {
  for_each = {
    name = each.key
  }
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = merge({
    environment = "leonard"
  }, var.commontags)
}

