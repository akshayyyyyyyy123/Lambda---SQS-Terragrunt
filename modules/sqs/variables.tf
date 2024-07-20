
variable "queue_name" {
  type = string
}

variable "visibility_timeout_seconds" {
  type = number
}

variable "max_message_size" {
  type = number
}

variable "delay_seconds" {
  type = number
}

variable "receive_wait_time_seconds" {
  type = number
}

variable "maxReceiveCount" {
  type = number
}

variable "sqs_tag" {
  type = string
}

variable "dlq_name" {
  type = string
}

variable "message_retention_dlq" {
  type = number
}

variable "max_message_size_dlq" {
  type = string
}

variable "dlq_tag" {
  type = string
}

# variable "lambda_arn_for_sqs_trigger" {
#   type = string
# }