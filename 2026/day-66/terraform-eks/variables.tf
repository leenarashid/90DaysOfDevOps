variable region {
    description = "AWS Region"
    default = "us-west-2" 
    type = string
}

variable cluster_name {
    description = "Cluster Name"
    default = "TerraWeek-eks"
    type = string
}
variable cluster_version {
    description = "Cluster Version"
    default = "1.31"
    type = string
}
variable node_instance_type {
    description = "Node Instance Type"
    default = "t3.medium"
    type = string
}
variable node_desired_count {
    description = "Node Desired Count"
    default = 2
    type = number
}
variable vpc_cidr {
    description = "VPC CIDR BLOCK"
    default = "10.0.0.0/16"
    type = string
}