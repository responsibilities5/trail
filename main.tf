variable "aws_access_key" {}

variable "aws_secret_key" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"

}

#here



resource "aws_instance" "ec2" {
  ami               = "ami-048f6ed62451373d9"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "NewAccount"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.interface.id
  }
  
  #user_data = <<-EOF
  #            #!/bin/sh
   #           sudo yum 
  #
  
  tags = {
    Name = "ubuntu"
  }

}

output "server_public_ip" {
  value = aws_eip.eip.public_ip
  }

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "gateway"
  }
}

resource "aws_route_table" "routetable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.gateway.id

  }
}

resource "aws_subnet" "subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_route_table_association" "associate" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.routetable.id
}

resource "aws_security_group" "security_group" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group"
  }

}

resource "aws_network_interface" "interface" {

  subnet_id       = aws_subnet.subnet.id
  private_ips     = ["10.0.0.50"]
  security_groups = [aws_security_group.security_group.id]



}

resource "aws_eip" "eip" {
  vpc                       = true
  network_interface         = aws_network_interface.interface.id
  associate_with_private_ip = "10.0.0.50"
  depends_on = [
    aws_internet_gateway.gateway
  ]
}

