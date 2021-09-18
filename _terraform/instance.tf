resource "aws_security_group" "allow-ssh" {
  vpc_id      = aws_vpc.production-vpc.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4200
    to_port     = 4200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh"
  }
}

resource "aws_instance" "server" {
  ami                         = "ami-09e67e426f25ce0d7"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public-subnet-1.id
  vpc_security_group_ids      = [aws_security_group.allow-ssh.id]
  associate_public_ip_address = true
  key_name                    = "jino"
  # user_data              = data.template_file.user_data_mongodb_server.rendered
  availability_zone = "${var.region}a"
}
