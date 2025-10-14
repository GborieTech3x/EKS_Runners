# Cluster
#Only deployed to the MGMT env
resource "aws_eks_cluster" "main" {
  for_each = { for cluster in var.eks_clusters : cluster.name => cluster }
  name     = format(local.eks_cluster_name_format, each.value.instance_number)
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids              = [aws_subnet.placeholder]
    endpoint_private_access = true
    endpoint_public_access  = false
    security_group_ids      = [aws_security_group.eks_sg.id]
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]


  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policies]
}

resource "aws_eks_addon" "add_ons" {
  for_each = flatten([for cluster in var.eks_clusters : [
    for addon in cluster.add_ons : {
      name                = pol.name
      version             = try(pol.version, null)
      configuration_value = try(pol.configuration_value, null)
  }]])
  cluster_name         = aws_eks_cluster.main.name
  addon_name           = each.value.name
  addon_version        = each.value.version
  configuration_values = each.value.configuration_values
  tags                 = try(merge(var.tags, each.value.tags), null)
}


# Node Group
resource "aws_eks_node_group" "node_group" {
  for_each        = { for node in var.eks_nodes : node.name => node }
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "eks-runners-node-group"
  node_role_arn   = aws_iam_role.node_group_roles.arn
  subnet_ids      = [aws_subnet.prv-az1.id, aws_subnet.prv-az2.id, aws_subnet.prv-az3.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.large"]
  depends_on     = [aws_iam_role_policy_attachment.eks_node_policies]
}

