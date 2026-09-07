variable "instance_type" {
  description = "Type of instance to create"
  type        = string
  default     = "t2.micro"
  # se botar true ele nao aparece no plan
  sensitive = false
}

# variable "name" {
#   type        = string
#   description = "Name of environment"
# }

# variable "db_feature" {
#   type        = bool
#   default     = false
#   description = "Enable DB feature"
# }

variable "instances" {
  type = set(string)
  description = "List of instance names to create"
}