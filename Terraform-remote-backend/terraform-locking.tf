terraform {
  required_version = ">= 0.11.0"
}

provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_s3_bucket" "locking"
  bucket = "${var.aws_bucket}"
  tags = {
    Description = "For state-locking"
  }
}

resource "aws_dynamodb_table" "state-locking"
  name = "${var.aws_table}"
  hash_key = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}
terraform {
  backend "s3" {
    bucket = aws_s3_bucket.locking.name
    key = "terraform.tfstate"
    region = "${var.aws_region}"
    dynamodb_table = aws_dynamodb_table.state-locking.name
  }
}
