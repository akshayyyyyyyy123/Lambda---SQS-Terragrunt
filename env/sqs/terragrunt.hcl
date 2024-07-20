terraform {
    source = "../..//modules/sqs"
}

// dependency "lambda" {
//     config_path = "../lambda"
// }

inputs = {

    # standard-queue config
    queue_name = "akshay-standard-queue"
    visibility_timeout_seconds = 30
    max_message_size = 2048
    delay_seconds = 90
    receive_wait_time_seconds = 20
    maxReceiveCount = 4
    sqs_tag = "stage-sqs"

    # dead-letter-queue config
    dlq_name = "akshay-dlq"
    message_retention_dlq = 86400
    max_message_size_dlq = 2048
    dlq_tag = "stage-dlq"

    # dependency injection
    # lambda_arn_for_sqs_trigger = dependency.lambda.outputs.lambda_arn
}