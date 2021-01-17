variable "regnames" {}
variable "commontags" {}

resource "aws_ecr_repository" "foo" {
  for_each             = var.regnames
  image_tag_mutability = "MUTABLE"
  name                 = each.key

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = merge({
    environment = "leonard"
  }, var.commontags)
}

