terraform {
  required_version = ">= 0.11.0"
}
provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_dynamodb_table" "friends"
  name "${var.aws_table}"
  hash_key = "UserId"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "friends-info"
  table_name = aws_dynamodb_table.friends.name
  hash_key = aws_dynamodb_table.friends.hash_key
  item = <<EOF
  
  {
    "Name" : {"S" : "Mang"},
    "DOB" : {"N" : "1998"},
    "Occupation" : {"S" : "Producer"},
    "UserId : {"S": "a01"},
  }
EOF
}
