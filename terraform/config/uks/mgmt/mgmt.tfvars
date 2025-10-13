eks_clusters = [
    {
        name = "default-cluster"
        add_ons = [
            {
                name = "amazon-cloudwatch-observability"
            },
            {
                name = "coredns"
            },
            {
                name = "kube-proxy"
            },
            {
                name = "vpc-cni"
            },
        ] 
        policies = [
            {
                policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
            },
            {
                policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
            },
            {
                policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
            },
            {
                policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
            }
        ]
    }

]
