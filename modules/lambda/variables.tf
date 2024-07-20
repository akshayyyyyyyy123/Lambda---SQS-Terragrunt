
variable "filename" {
  type = string
  default = "lambda_function_payload.zip"
}

variable "function_name" {
  type = string
}

variable "runtime" {
  type = string
  default = "python3.8"
}

variable "tag" {
  type = string
  default = "value"
}

variable "lambda_inline_policy_name" {
  type = string
}

variable "standard_queue_arn" {
  type = string
}