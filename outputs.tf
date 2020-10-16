output "command" {
  value = local.ansible_command_engine
}

output "ip_instance" {
  value = aws_instance.example.public_ip
}
