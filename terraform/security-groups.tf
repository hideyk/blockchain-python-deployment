resource "aws_security_group" "worker_node_sg" {
    name = "worker_node_security_group"
    description = "Allow inbound HTTP(s)"
    vpc_id = aws_vpc.main.id
    ingress {
        description      = "HTTP default port"
        from_port        = 11000
        to_port          = 11000
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
        description      = "HTTP default port"
        from_port        = 11000
        to_port          = 11000
        protocol         = "tcp"
        cidr_blocks      = [aws_vpc.main.cidr_block]
    }

    tags = {
        Name = "Worker Node Security Group"
    }
}
