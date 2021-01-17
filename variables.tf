variable "accesskey" {}
variable "secretkey" {}

#locals {
#    module = basename(abspath(path.module))
#}
variable "ecrnames" {
  type    = list(string)
  default = ["nginx", "flask", "django", "msgapi"]
}
variable "roottags" {
  description = "Commona Tags applicable to all objects"
  default = { terraformed = true,
    Name   = "NameVar",
    Module = 1
  }
}
