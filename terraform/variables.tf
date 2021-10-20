variable "project_name" {
    description = "Project Name"
    type = string
    default = "blockchain-python"
}

variable "region" {
    description = "AWS Region"
    type = string
    default = "ap-southeast-1"
}

variable "key_pair" {
    description = "Key pair for SSH"
    type = string
}

variable "worker_ami" {
    description = "AMI for Web instances"
    type = string
    default = "ami-0d058fe428540cd89"
}

variable "worker_instance_type" {
    description = "Instance type for Web instances"
    type = string
    default = "t3.micro"
}

variable "worker_hostname" {
    description = "Hostname for Web instances"
    type = string
    default = "hidey-blockchain-node"
}
