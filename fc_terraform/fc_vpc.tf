#create vpc
resource "aws_vpc" "fc_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"
}

#create public subnet
resource "aws_subnet" "fc_public" {
  vpc_id = "${aws_vpc.fc_vpc.id}"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-west-2a"
}

#create private subnet
resource "aws_subnet" "fc_private" {
  vpc_id = "${aws_vpc.fc_vpc.id}"
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-west-2c"
}

#creates internet gateway
resource "aws_internet_gateway" "fc_gw" {
  vpc_id = "${aws_vpc.fc_vpc.id}"
}

#creates routing table for public subnet
resource "aws_route_table" "route_public" {
  vpc_id = "${aws_vpc.fc_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.fc_gw.id}"
  }
}

#create routing table for private subnet
resource "aws_route_table" "route_private" {
  vpc_id = "${aws_vpc.fc_vpc.id}"
}

#associates routing table to subnets
resource "aws_route_table_association" "pub" {
  subnet_id = "${aws_subnet.fc_public.id}"
  route_table_id = "${aws_route_table.route_public.id}"
}

resource "aws_route_table_association" "priv" {
  subnet_id = "${aws_subnet.fc_private.id}"
  route_table_id = "${aws_route_table.route_private.id}"
}
