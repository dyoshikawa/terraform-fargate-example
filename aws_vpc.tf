resource "aws_vpc" "main" {
  cidr_block = "${var.root_segment}"

  tags {
    Name = "${var.app_name}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.app_name} igw"
  }
}

resource "aws_subnet" "public1" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public_segment1}"
  availability_zone = "${var.public_segment1_az}"

  tags {
    Name = "${var.app_name} public-subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${var.public_segment2}"
  availability_zone = "${var.public_segment2_az}"

  tags {
    Name = "${var.app_name} public-subnet2"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }

  tags {
    Name = "${var.app_name} public-rt"
  }
}

resource "aws_route_table_association" "main1" {
  subnet_id      = "${aws_subnet.public1.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "main2" {
  subnet_id      = "${aws_subnet.public2.id}"
  route_table_id = "${aws_route_table.public.id}"
}
