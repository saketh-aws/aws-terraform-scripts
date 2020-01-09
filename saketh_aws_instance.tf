provider "aws" {
        access_key = "AKIA4OH2BTMCBSBMEA7S"
        secret_key = "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"
        region = "us-east-1"
}

resource "aws_vpc" "tf_vpc" {
  cidr_block       = "11.11.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "tf_vpc"
  }
}

resource "aws_subnet" "tf_s1" {
  vpc_id     = "${aws_vpc.tf_vpc.id}"
  cidr_block = "11.11.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf_s1"
  }
}

resource "aws_subnet" "tf_s2" {
  vpc_id     = "${aws_vpc.tf_vpc.id}"
  cidr_block = "11.11.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "tf_s2"
  }
}

resource "aws_subnet" "tf_s3" {
  vpc_id     = "${aws_vpc.tf_vpc.id}"
  cidr_block = "11.11.13.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "tf_s3"
  }
}

resource "aws_internet_gateway" "tf_igw" {
  vpc_id = "${aws_vpc.tf_vpc.id}"

  tags = {
    Name = "tf_igw"
  }
}


resource "aws_route" "tf_r" {
  route_table_id              = "${aws_vpc.tf_vpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id      = "${aws_internet_gateway.tf_igw.id}"
}

resource "aws_security_group" "tf_sg" {
  name        = "tf_sg"
  description = "Allow TCP inbound traffic"
  vpc_id      = "${aws_vpc.tf_vpc.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 0
    to_port     = 6553
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "tf_server" {
        ami = "ami-00eb20669e0990cb4"
        instance_type = "t2.micro"
        key_name = "sakethtest"
        subnet_id = "${aws_subnet.tf_s1.id}"
        associate_public_ip_address = "true"
        security_groups= ["${aws_security_group.tf_sg.id}"]
        tags = {
         Name = "server"
        }
}

resource "aws_instance" "tf_client1" {
        ami = "ami-00eb20669e0990cb4"
        instance_type = "t2.micro"
        key_name = "sakethtest"
        subnet_id = "${aws_subnet.tf_s1.id}"
        associate_public_ip_address = "true"
        security_groups= ["${aws_security_group.tf_sg.id}"]
        tags = {
         Name = "client1"
        }
}

resource "aws_instance" "tf_client2" {
        ami = "ami-00eb20669e0990cb4"
        instance_type = "t2.micro"
        key_name = "sakethtest"
        subnet_id = "${aws_subnet.tf_s2.id}"
        associate_public_ip_address = "true"
        security_groups= ["${aws_security_group.tf_sg.id}"]
        tags = {
         Name = "client2"
        }
}

resource "aws_instance" "tf_client3" {
        ami = "ami-00eb20669e0990cb4"
        instance_type = "t2.micro"
        key_name = "sakethtest"
        subnet_id = "${aws_subnet.tf_s3.id}"
        associate_public_ip_address = "true"
        security_groups= ["${aws_security_group.tf_sg.id}"]
        tags = {
         Name = "client3"
        }
}


