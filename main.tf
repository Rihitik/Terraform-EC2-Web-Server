provider "aws" {
  region = "ap-south-1"
}

# Use Existing Default VPC

data "aws_vpc" "default" {
  default = true
}

# Security Group

resource "aws_security_group" "web_sg" {

  name        = "terraform-webserver-sg"
  description = "Allow HTTP and SSH"

  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

# EC2 Instance

resource "aws_instance" "web" {

  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t2.micro"

  subnet_id = "subnet-0391feeb69966b00f"

  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]

  user_data = file("install.sh")

  tags = {
    Name = "Terraform-WebServer"
  }
}
