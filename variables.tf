variable "project" {

        default = "task-vpc"
}

variable "vpc_cidr" {

        default = "172.16.0.0/16"

}
# Public subnet 1
variable "public1" {
        type    = map
        default = {
                "cirdr" = "172.16.0.0/19"
                "zone"  = "us-east-2a"
        }

}

# Public subnet 2

variable "public2" {
        type    = map
        default = {
                "cirdr" = "172.16.32.0/19"
                "zone"  = "us-east-2b"
        }

}

# Public subnet 3

variable "public3" {
        type    = map
        default = {
                "cirdr" = "172.16.64.0/19"
                "zone"  = "us-east-2c"
        }

}


# Private subnet 1
variable "private1" {
        type    = map
        default = {
                "cirdr" = "172.16.96.0/19"
                "zone"  = "us-east-2a"
        }

}

# Private subnet 2

variable "private2" {
        type    = map
        default = {
                "cirdr" = "172.16.128.0/19"
                "zone"  = "us-east-2b"
        }

}

# Private subnet 3

variable "private3" {
        type    = map
        default = {
                "cirdr" = "172.16.160.0/19"
                "zone"  = "us-east-2c"
        }

}


# Variable for AMI

variable "insta" {
        type    = map
        default = {
                "ami" = "ami-0277b52859bac6f4b"
                "type"  = "t2.micro"
        }

}
