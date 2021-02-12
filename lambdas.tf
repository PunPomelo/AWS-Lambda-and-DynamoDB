# terraform {
#   required_providers {
#     aws = {
#       source = "hashicorp/aws"
#     }
#   }
# }

# provider "aws" {
#   region = "us-west-1"
# }

resource "aws_lambda_function" "getUserData" {
  function_name = "getUserData"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = "get-user-data-tf"
  s3_key    = "v1.0.0/getUserData.zip"

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  handler = "index.handler"
  runtime = "nodejs14.x"

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role_policy" "dynamo_rw_access" {
  name = "DynamoReadWriteAccess"
  role = aws_iam_role.lambda_exec.id

  # TODO: try to use resource from dynamodb.tf 
  policy = <<-EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:GetItem"
            ],
            "Resource": "arn:aws:dynamodb:us-west-1:659043227432:table/Users"
        }
    ]
}
  EOF
}

resource "aws_iam_role" "lambda_exec" {
  name               = "LambdaDynamoDBRoleTF"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}
