
# create an assume role for lambda service
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# attach the policy which writes the message to Cloudwatch service
resource "aws_iam_policy" "lambda_cloudwatch_policy" {
  name        = var.lambda_inline_policy_name
  description = "Policy that allows Lambda functions to write logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Resource = var.standard_queue_arn
      }
    ]
  })
}

# create an iam role for lambda
resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# attach the inline policy to the role
resource "aws_iam_policy_attachment" "inline_policy_attachment_for_lambda_role" {
  name = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_cloudwatch_policy.arn
  roles      = [aws_iam_role.iam_for_lambda.name]
}

# creates a zip file of the python code
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "code.py"
  output_path = "lambda_function_payload.zip"
}

# lambda function config
resource "aws_lambda_function" "my_lambda" {
  filename = var.filename
  function_name = var.function_name
  role = aws_iam_role.iam_for_lambda.arn
  handler = "code.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = var.runtime
  
  tags = {
    Name = var.tag
  }  
}

# add sqs trigger to the lambda function
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.standard_queue_arn
  function_name    = aws_lambda_function.my_lambda.arn
  enabled          = true
  batch_size       = 10
}

