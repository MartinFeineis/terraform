variable "roottags" {}
variable "moduletags" {
  type    = map(string)
  default = { module = "testy" }
}
