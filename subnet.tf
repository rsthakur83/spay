###### Provision Public, APP & Database  Subnet

#### Public Subnet 1
resource "aws_subnet" "pub_subnet_1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.aws_pub_subnet_1_cidr
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "Public Subnet 1"
  }
}

#### Public Subnet 2
resource "aws_subnet" "pub_subnet_2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.aws_pub_subnet_2_cidr
  availability_zone = var.availability_zone[1]
  tags = {
    Name = "Public Subnet 2"
  }
}

#### APP Subnet 1
resource "aws_subnet" "app_subnet_1" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.aws_app_subnet_1_cidr
  availability_zone = var.availability_zone[0]
  tags = {
    Name = "APP Subnet 1"
  }

}

#### APP Subnet 2
resource "aws_subnet" "app_subnet_2" {
  vpc_id            = aws_vpc.app_vpc.id
  cidr_block        = var.aws_app_subnet_2_cidr
  availability_zone = var.availability_zone[1]
  tags = {
    Name = "APP Subnet 2"
  }
}

