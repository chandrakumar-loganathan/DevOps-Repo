#Create the VPC
resource "aws_vpc" "vpc" {             # Creating VPC here
  cidr_block       = var.main_vpc_cidr # Defining the CIDR block use 10.0.0.0/16 for demo
  instance_tenancy = "default"
  tags = {
    Name        = var.vpc_name
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

resource "aws_internet_gateway" "IGW" { # Creating Internet Gateway
  vpc_id = aws_vpc.vpc.id               # vpc_id will be generated after we create VPC
  tags = {
    Name = var.igw_name
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.IGW]
}


# Create NAT gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.IGW]
  tags = {
    Name        = var.nat_gw_name_1
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.environment}-${element(var.public_subnets_cidr, count.index)}-public-subnet"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnet_rt_zone_1a)
  cidr_block              = element(var.private_subnet_rt_zone_1a, count.index)
  availability_zone       = element(var.availability_zones, 0)
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-${element(var.private_subnet_rt_zone_1a, count.index)}-private-subnet"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnet_rt_zone_1b)
  cidr_block              = element(var.private_subnet_rt_zone_1b, count.index)
  availability_zone       = element(var.availability_zones, 1)
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-${element(var.private_subnet_rt_zone_1b, count.index)}-private-subnet"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.vpc.id
  count                   = length(var.private_subnet_rt_zone_1c)
  cidr_block              = element(var.private_subnet_rt_zone_1c, count.index)
  availability_zone       = element(var.availability_zones, 2)
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.environment}-${element(var.private_subnet_rt_zone_1c, count.index)}-private-subnet"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

# Routing table for private subnet
resource "aws_route_table" "private1" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-private-route-table-AZ1"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

resource "aws_route_table" "private2" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-private-route-table-AZ2"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

resource "aws_route_table" "private3" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-private-route-table-AZ3"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

# Routing table for public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name        = "${var.environment}-public-route-table"
    Environment = "${var.environment}"
    Product     = "${var.product_name}"
  }
}

#Associate Internet gateway with public subnet
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
}

#Associate NAT gateway with private subnets
resource "aws_route" "private_nat_gateway1" {
  route_table_id         = aws_route_table.private1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route" "private_nat_gateway2" {
  route_table_id         = aws_route_table.private2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route" "private_nat_gateway3" {
  route_table_id         = aws_route_table.private3.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

#Public route table association
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

#Private route table association
resource "aws_route_table_association" "private1" {
  count          = length(var.private_subnet_rt_zone_1a)
  subnet_id      = element(aws_subnet.private_subnet_1.*.id, count.index)
  route_table_id = aws_route_table.private1.id
}

#Private route table association
resource "aws_route_table_association" "private2" {
  count          = length(var.private_subnet_rt_zone_1b)
  subnet_id      = element(aws_subnet.private_subnet_2.*.id, count.index)
  route_table_id = aws_route_table.private2.id
}

#Private route table association
resource "aws_route_table_association" "private3" {
  count          = length(var.private_subnet_rt_zone_1c)
  subnet_id      = element(aws_subnet.private_subnet_3.*.id, count.index)
  route_table_id = aws_route_table.private3.id
}
