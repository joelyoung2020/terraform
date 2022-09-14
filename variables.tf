variable "region" {
  default = "eu-west-3"
  description = "AWS region"
}
variable "cluster_name" {
  default = "getting-started-eks"
}
variable "map_roles" {
  description = "roles in the cluster"
  default =  [
    {
      rolearn  = "arn:aws:iam::069269258193:role/eksClusterRole"
      username = "role1"
      groups   = ["system:masters"]
    }
  ]
}
variable "map_users" {
  description = "users in the cluster"
  default = [
    {
      userarn  = "arn:aws:iam::069269258193:user/Joel"
      username = "user1"
      groups   = ["system:masters"]
    }
  ]
}
