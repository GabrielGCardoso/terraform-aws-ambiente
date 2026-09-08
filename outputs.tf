output "instance_ip" {
  description = "IP privado da maquina virtual"
  value       = { for key, instance in aws_instance.this : key => instance.private_ip }
}