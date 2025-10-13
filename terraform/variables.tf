# General
variable "location" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

# EKS
variable "eks_nodes" {
  type = list(object({
    name = string

    policies = list(object({
      arn = string
    }))
  }))
  default     = []
  description = <<EKS_NODES
    A list of objects containing eks node groups.
    name - The name of the eks node group
    policies - A list of objects containing eks node iam policies.
        `arn` - ARN of the IAM policy.

  EKS_NODES
}

variable "eks_clusters" {
  type = list(object({
    name = string
    add_ons = list(object({
      name                 = string
      version              = optional(string, null)
      configuration_values = optional(string, null)
      tags                 = optional(map(string), {})
    }))
    policies = list(object({
      arn = string
    }))
  }))
  default     = []
  description = <<EKS_CLUSTERS
    A list of objects containing eks clusters.
    name - The name of the eks cluster
    policies - A list of objects containing eks cluster iam policies.
        `arn` - 
    add_ons - A list of objects containing eks cluster.
        `name` - Name of the EKS add-on. The name must match one of the names returned by describe-addon-versions.
        `version` -  The version of the EKS add-on. The version must match one of the versions returned by describe-addon-versions.
        `configuration_values` - Custom configuration values for addons with single JSON string. This JSON string value must match the JSON schema derived from describe-addon-configuration.
        ` Key-value map of resource tags` -  Key-value map of resource tags
  EKS_CLUSTERS
}

