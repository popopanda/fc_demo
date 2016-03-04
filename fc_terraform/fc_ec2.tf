#keypair

#creates webserver instance with a count of 1 using ubuntu 14.04 ami
resource "aws_instance" "fc_webserver" {
  count = "1"
  ami = "ami-9abea4fb"
  instance_type = "t2.micro"
  key_name = "fckey"
  vpc_security_group_ids = ["${aws_security_group.webserver_sg.id}"]
  subnet_id = "${aws_subnet.fc_public.id}"
  tags {
    Name = "${format("webserver-%02d", count.index + 1)}"
  }
}

#creates dbserver instance
resource "aws_instance" "fc_db" {
  count = "1"
  ami = "ami-9abea4fb"
  instance_type = "t2.micro"
  key_name = "fckey"
  vpc_security_group_ids = ["${aws_security_group.dbserver_sg.id}"]
  subnet_id = "${aws_subnet.fc_private.id}"
  tags {
    Name = "${format("dbserver-%02d", count.index + 1)}"
  }
}
