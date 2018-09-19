provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "prometheus-server" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name      = "${aws_key_pair.access_key.key_name}"

  security_groups = [
    "${aws_security_group.ssh_access.name}",
    "${aws_security_group.prometheus_web_access.name}",
    "${aws_security_group.reach_drone.name}"
  ]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
    }

    scripts = [
      "scripts/install-prometheus.sh",
    ]
  }

  tags {
    Name = "${var.name}"
  }
}

resource "aws_security_group" "ssh_access" {
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "prometheus_web_access" {
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_security_group" "reach_drone" {
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "access_key" {
  key_name   = "access"
  public_key = "${var.public_key}"
}
