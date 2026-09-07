variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
  # se botar true ele nao aparece no plan
  sensitive = false
}

variable "name" {
  type        = string
  description = "Name of environment"
}