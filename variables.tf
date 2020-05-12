variable "api" {
  description = "id of an aws_api_gateway_rest_api resource"
}

variable "resource" {
  description = "id of an aws_api_gateway_resource resource"
}

variable "methods" {
  type        = list(string)
  description = "List of permitted HTTP methods. OPTIONS is added by default."
}

variable "origin" {
  description = "Permitted origin"
  default     = "*"
}

variable "headers" {
  description = "List of permitted headers. Default headers are alway present unless discard_default_headers variable is set to true"
  default     = ["Content-Type", "X-Amz-Date", "Authorization", "X-Api-Key", "X-Amz-Security-Token"]
}

variable "discard_default_headers" {
  default     = false
  description = "When set to true to it discards the default permitted headers and only includes those explicitly defined"
}

locals {
  methodOptions  = "OPTIONS"
  defaultHeaders = ["Content-Type", "X-Amz-Date", "Authorization", "X-Api-Key", "X-Amz-Security-Token"]

  methods = join(",", distinct(concat(var.methods, [local.methodOptions])))
  headers = var.discard_default_headers ? join(",", var.headers) : join(",", distinct(concat(var.headers, local.defaultHeaders)))
}

