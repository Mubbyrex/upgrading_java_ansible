provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

resource "aws_instance" "java-install-test-instance" {
  ami           = data.aws_ami.amazon-linux-image.id
  instance_type = "t3.small"
  key_name      = "iam_mubarak" # Replace with your key pair name
  security_groups = [aws_security_group.allow_ssh.name]
  tags = {
    Name = "java-install-test-instance"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow-ssh"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.java-install-test-instance.public_ip
}