# locals {
#   instance_name = "InstanceName" # lower(var.name)
# }

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
  instance_type = each.value["instance_type"]

  tags = {
    Name = "name"
  }
  
  # Exemplo ebs hard coded
  # ebs_block_device {
  #   device_name = "/dev/sdb"
  #   volume_size = "50"
  # }

  dynamic "ebs_block_device" {
    for_each = var.volumes-extras

    content {
      device_name = ebs_block_device.value["device_name"]
      volume_size = ebs_block_device.value["volume_size"]
    }
  }
}

# resource "aws_instance" "db" {
#   # count = var.db_feature && var.env == "prod" ? 1 : 0
#   # count         = var.db_feature ? 1 : 0
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.instance_type
# }
