terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Users"
#   billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"
#   range_key      = "GameTitle"

  attribute {
    name = "id"
    type = "S"
  }

#   attribute {
#     name = "firstname"
#     type = "S"
#   }

#   attribute {
#     name = "lastname"
#     type = "S"
#   }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

#   global_secondary_index {
#     name               = "GameTitleIndex"
#     hash_key           = "GameTitle"
#     range_key          = "TopScore"
#     write_capacity     = 10
#     read_capacity      = 10
#     projection_type    = "INCLUDE"
#     non_key_attributes = ["UserId"]
#   }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}
# resource "aws_dynamodb_table" "us-east-1" {
#   provider = aws.us-east-1

#   hash_key         = "id"
#   name             = "Users"
#   stream_enabled   = true
#   stream_view_type = "NEW_AND_OLD_IMAGES"
#   read_capacity    = 1
#   write_capacity   = 1

#   attribute {
#     name = "id"
#     type = "S"
#   }
#   attribute {
#     name = "firstname"
#     type = "S"
#   }
#   attribute {
#     name = "lastname"
#     type = "S"
#   }

# }

# resource "aws_dynamodb_table" "us-west-1" {
#   provider = aws.us-west-1

#   hash_key         = "myAttribute"
#   name             = "myTable"
#   stream_enabled   = true
#   stream_view_type = "NEW_AND_OLD_IMAGES"
#   read_capacity    = 1
#   write_capacity   = 1

#   attribute {
#     name = "myAttribute"
#     type = "S"
#   }
# }

# resource "aws_dynamodb_global_table" "myTable" {
#   depends_on = [
#     aws_dynamodb_table.us-east-1,
#     aws_dynamodb_table.us-west-1,
#   ]
#   provider = aws.us-east-1

#   name = "myTable"

#   replica {
#     region_name = "us-east-1"
#   }

#   replica {
#     region_name = "us-west-1"
#   }
# }