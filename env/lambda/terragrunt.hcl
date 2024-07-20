
terraform {
    source = "../..//modules/lambda"
}

dependency "sqs" {
    config_path = "../sqs"
}

inputs = {
  function_name = "akshay-test-lambda"
  runtime = "python3.8"
  tag = "stage-lambda"
  lambda_inline_policy_name = "CloudWatchLambdaPolicy"
  standard_queue_arn = dependency.sqs.outputs.standard_queue_arn
}