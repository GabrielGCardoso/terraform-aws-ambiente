locals {
  instance_name = lower(var.name)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = local.instance_name
  }
}

resource "aws_instance" "db" {
  # count = var.db_feature && var.env == "prod" ? 1 : 0
  count         = var.db_feature ? 1 : 0
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
}
