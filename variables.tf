variable "accesskey" {}
variable "secretkey" {}

#locals {
#    module = basename(abspath(path.module))
#}

variable "roottags" {
  description = "Commona Tags applicable to all objects"
  default = { terraformed = true,
    Name   = "NameVar",
    Module = 1
  }
}
