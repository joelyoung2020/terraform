variable "region" {
  default = "ap-southeast-2"
  description = "AWS region"
}
variable "cluster_name" {
  default = "getting-started-eks"
}
variable "map_roles" {
  description = "roles in the cluster"
  default =  [
    {
      rolearn  = "arn:aws:iam::66666666666:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    }
  ]
}
variable "map_users" {
  description = "users in the cluster"
  default = [
    {
      userarn  = "arn:aws:iam::66666666666:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    }
  ]
}
