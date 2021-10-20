output "worker_node_ip" {
  value = aws_instance.worker_node.public_ip
}
