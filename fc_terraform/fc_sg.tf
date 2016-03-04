#webserver security group
#permits 22, 80, 443 from 0.0.0.0/0 - inbound
#permits all to 0.0.0.0/0 - outbound
resource "aws_security_group" "webserver_sg" {
  name = "webserver_sg"
  description = "permit http and https from public internet"
  vpc_id = "${aws_vpc.fc_vpc.id}"
  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#dbserver security group
#permits 22, 3306 from 10.0.0.0/24 subnet_id
#permit port 80, 443 - outbound
resource "aws_security_group" "dbserver_sg" {
  name = "dbserver_sg"
  description = "permit mysql port 3306 from 10.0.0.0/24"
  vpc_id = "${aws_vpc.fc_vpc.id}"
  ingress {
    from_port = "3306"
    to_port = "3306"
    protocol = "tcp"
    security_groups = ["${aws_security_group.webserver_sg.id}"]
  }
  /*ingress {
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    security_groups = ["${aws_security_group.webserver_sg.id}"]
  }*/
  egress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = "443"
    to_port = "443"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
