variable "currency" {}
variable "monthly_billing_threshold" {}
variable "roottags" {}

variable "moduletags" {
  type    = map(any)
  default = { module = "billing" }
}
