variable "accesskey" {}
variable "secretkey" {}

locals {
    module = basename(abspath(path.module))
}


variable "commontags" {
  description = "Commona Tags applicable to all objects"
  default = { terraformed = true,
    Name   = local.Name,
    Module = local.module
  }
}
