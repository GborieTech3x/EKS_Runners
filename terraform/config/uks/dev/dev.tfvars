# EKS
eks_nodes = [
  {
    name = "runner-node-group"

    roles = [
      {
        name = "eks_runner_node_group_role"
      }
    ]
    policies = [
      {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
      },
      {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      },
      {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      },
      {
        policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
      },
      {
        policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
      }
    ]
  }

]
