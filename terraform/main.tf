########################
# PROVIDER
########################

provider "aws" {
    region = var.region
}

########################
# AWS VPC
########################

resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${var.project_name} VPC"
    }
}

########################
# EC2 Instances
########################

resource "aws_instance" "worker_node" {
    ami = var.worker_ami
    instance_type = var.worker_instance_type
    key_name      = var.key_pair
    subnet_id     = aws_subnet.primary.id
    vpc_security_group_ids = [
        aws_security_group.worker_node_sg.id
    ]
    
    user_data = <<-EOF
		#! /bin/bash
        sudo hostnamectl set-hostname ${var.worker_hostname}
	    EOF

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_pair}.pem")
      host        = self.public_ip
    }

    #####################
    # Setup Ansible service on Worker node
    #####################
    provisioner "remote-exec" {
        scripts = ["shell/ansible-setup.sh"]
    }

    #####################
    # Copy Ansible playbooks to Worker node
    #####################
    provisioner "file" {
        source = "../ansible"
        destination = "/home/ubuntu/blockchain"
    }

    #####################
    # Run Ansible playbook on Worker node
    #####################
    provisioner "remote-exec" {
        scripts = ["shell/ansible-run.sh"]
    }

    tags = {
        Name = "Worker Node Instance"
    }
}

