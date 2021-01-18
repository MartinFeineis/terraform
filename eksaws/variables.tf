variable "roottags" {}
variable "moduletags" {
  type    = map(any)
  default = { Module = "eksaws" }
}

