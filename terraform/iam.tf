resource "aws_iam_role" "eks_cluster" {
  name = "eks_cluster_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policies" {
  for_each = flatten([for cluster in var.eks_clusters : [
    for pol in cluster.policies : {
      policy_arn = pol.arn
  }]])
  policy_arn = each.value.policy_arn
  role       = aws_iam_role.eks_cluster.name
}

# Node Groups 
resource "aws_iam_role" "eks_node_group" {
  for_each = flatten([for node in var.eks_nodes : [
    for role in node.roles : {
      name = role.name
  }]])
  name = each.value.name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_policies" {
  for_each = flatten([for node in var.eks_nodes : [
    for pol in node.policies : {
      policy_arn = pol.arn
  }]])
  policy_arn = each.value.policy_arn
  role       = aws_iam_role.eks_node_group.name
}

