
# create standard queue
resource "aws_sqs_queue" "standard_queue" {
  name = var.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  max_message_size = var.max_message_size
  delay_seconds = var.delay_seconds
  receive_wait_time_seconds = var.receive_wait_time_seconds
  message_retention_seconds = "86400"

   redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = var.maxReceiveCount
  })

  tags = {
    Name = var.sqs_tag
  }
}

# dead letter queue
resource "aws_sqs_queue" "dead_letter_queue" {
  name = var.dlq_name
  message_retention_seconds = var.message_retention_dlq
  max_message_size = var.max_message_size_dlq

  tags = {
    Name = var.dlq_tag
  }
}

# add sqs trigger to the lambda function
# resource "aws_lambda_event_source_mapping" "sqs_trigger" {
#   event_source_arn = aws_sqs_queue.standard_queue.arn
#   function_name    = var.lambda_arn_for_sqs_trigger
#   enabled          = true
#   batch_size       = 10
# }
