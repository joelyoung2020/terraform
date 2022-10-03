output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value = module.eks.cluster_endpoint
}
output "cluster_security_group_id" {
  description = "Security group ids attched to the cluster control plane"
  value = module.eks.cluster_security_group_id
}
output "config_map_aws_auth" {
  description = "kubernetes configuration to authentiticate to this EKS cluster"
  value = module.eks.aws_auth_configmap_yaml
}
output "region" {
  description = "AWS region"
  value = var.region
}
