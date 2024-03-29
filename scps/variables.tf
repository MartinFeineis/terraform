variable "moduletags" {
  type    = map(any)
  default = { module = "scps" }
}

#-----security_controls_scp/modules/s3/variables.tf----#
variable "target_id" {
  description = "The Root ID, Organizational Unit ID, or AWS Account ID to apply SCPs."
  type        = string
}

variable "region_lockdown" {
  description = "The AWS region(s) you want to restrict resources to."
  type        = list(string)
}
