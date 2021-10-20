resource "aws_security_group" "worker_node_sg" {
    name = "worker_node_security_group"
    description = "Allow inbound HTTP(s)"
    vpc_id = aws_vpc.main.id

    ingress {
        description      = "Custom mapped port"
        from_port        = 5000
        to_port          = 5000
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description      = "Nginx default port"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = [aws_vpc.main.cidr_block]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Load Balancer Security Group"
    }
}
