variable "api" {}

variable "resource" {}

variable "methods" {
  default = []
}

variable "origins" {
  default = ["*"]
}

variable "headers" {
  default = ["Content-Type", "X-Amz-Date", "Authorization", "X-Api-Key", "X-Amz-Security-Token"]
}

locals {
  methodOptions = "OPTIONS"
  defaultHeaders = ["Content-Type", "X-Amz-Date", "Authorization", "X-Api-Key", "X-Amz-Security-Token"]

  methods = "${join(",", distinct(concat(var.methods, list(local.methodOptions))))}"
  origins = "${join(",", var.origins)}"
  headers = "${join(",", distinct(concat(var.headers, local.defaultHeaders)))}"
}
