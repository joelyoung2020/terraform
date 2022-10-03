resource "aws_s3_bucket" "new"
  bucket = "joel-item0001"
  tags = {
    Description = "For fun file"
  }
}

resource "aws_s3_bucket_object" "new" {
  content = "/root/joelimage.img
  key = "joelimage.img"
  bucket = aws_s3_bucket.new.id
}

resource "aws_iam_group" "bucket-managers" {
  name = "bucket_managers"
}

resource "aws_s3_bucket_policy" "new_policy" {
  bucket = aws_s3_bucket.new.id
  policy = <<EOF
  
  {
    "Version": "2012-10-17",
    "Statement": [
       {
          "Action": "*",
          "Principal": {
            "AWS": [
               "${aws_iam_group.bucket-managers.arn}"
             ]
          },
          "Effect": "Allow",
          "Resource": "arn:aws:s3:::${aws_s3_bucket.new.id}"
        }
    ]
  }

  EOF
}
