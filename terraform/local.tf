locals {
  eks_cluster_name_format = "eks-cluster-${var.location}-${var.environment}-%s"
}
variable "environment" {
  type = string
}

