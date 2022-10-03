variable "aws_region" {
  description = "AWS region"
  default = "us-west-3"
}
variable "aws_bucket" {
  description = "AWS bcuket name"
  default = "for_state_locking"
}
variable "aws_table" {
  description = "AWS dynamodb table name"
  default = "state-locking"
}
