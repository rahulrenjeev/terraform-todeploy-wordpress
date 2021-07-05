#VPC creation

resource "aws_vpc" "vpc" {

  cidr_block            = var.vpc_cidr
  instance_tenancy      = "default"
  enable_dns_hostnames  = true
  tags = {
    Name = "${var.project}-vpc"
  }
}

data "aws_availability_zones" "zone-available" {
  state = "available"
}


## Public subnet creation 1

resource "aws_subnet" "public1" {

    vpc_id                         =  aws_vpc.vpc.id
    cidr_block                     =  cidrsubnet(var.vpc_cidr, 3, 0)
    availability_zone              =  data.aws_availability_zones.zone-available.names[0]
    map_public_ip_on_launch        = true
    tags = {
    Name = "${var.project}-public1"
  }

}


## Public subnet creation 2

resource "aws_subnet" "public2" {

    vpc_id                         =  aws_vpc.vpc.id
    cidr_block                     =  cidrsubnet(var.vpc_cidr, 3, 1)
    availability_zone              =  data.aws_availability_zones.zone-available.names[1]
    map_public_ip_on_launch        = true
    tags = {
    Name = "${var.project}-public2"
  }


}



## Public subnet creation 3

resource "aws_subnet" "public3" {

    vpc_id                         =  aws_vpc.vpc.id
    cidr_block                     =  cidrsubnet(var.vpc_cidr, 3, 2)
    availability_zone              =    data.aws_availability_zones.zone-available.names[2]
    map_public_ip_on_launch        = true
    tags = {
    Name = "${var.project}-public3"
  }


}


## Private subnet creation 1

resource "aws_subnet" "private1" {

    vpc_id                         =  aws_vpc.vpc.id
    cidr_block                     =  cidrsubnet(var.vpc_cidr, 3, 3)
    availability_zone              =  data.aws_availability_zones.zone-available.names[0]
    tags = {
    Name = "${var.project}-private1"
  }


}

## Private subnet creation 2

resource "aws_subnet" "private2" {

    vpc_id                         =  aws_vpc.vpc.id
    cidr_block                     =  cidrsubnet(var.vpc_cidr, 3, 4)
    availability_zone              =  data.aws_availability_zones.zone-available.names[1]
    tags = {
    Name = "${var.project}-private3"
  }


}
## Private subnet creation 3

resource "aws_subnet" "private3" {

    vpc_id                         =  aws_vpc.vpc.id
    cidr_block                     =  cidrsubnet(var.vpc_cidr, 3, 5)
    availability_zone              =  data.aws_availability_zones.zone-available.names[2]
    tags = {
    Name = "${var.project}-private3"
  }


}


### Internet gateway for VPC

resource "aws_internet_gateway" "IG" {
    vpc_id                         =  aws_vpc.vpc.id
    tags = {
    Name = "${var.project}-IG-VPC-task"
  }

}

## Need to allocate an elastic IP for Nat configuration

resource "aws_eip" "elip" {
    vpc                             = true
    tags = {
    Name = "${var.project}-EL-VPC-task"
  }
}

## Need to add Nat gateway for private subnet. We need to configure NAt under a public subnet

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elip.id
  subnet_id     = aws_subnet.public1.id
  tags = {
    Name = "${var.project}-Nat-VPC-task"
  }

}


# Creating the route tabe public

resource "aws_route_table" "pub-route" {

    vpc_id                         =  aws_vpc.vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }

  tags = {
    Name = "${var.project}-Pub-rout"
  }

}

# Creating the route tabe private

resource "aws_route_table" "pri-route" {

    vpc_id                         =  aws_vpc.vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project}-Pri-rout"
  }

}
#####Route table association with subnets

##public1 subnet to public route

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.pub-route.id
}



##public2 subnet to public route

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.pub-route.id
}

##public3 subnet to public route

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.pub-route.id
}


##private1 subnet to public route

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.pri-route.id
}

##private2 subnet to public route

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.pri-route.id
}

##private3 subnet to public route

resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.pri-route.id
}



