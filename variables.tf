variable "project" {

        default = "task-vpc"
}

variable "vpc_cidr" {

        default = "172.16.0.0/16"

}


variable "insta" {
        type    = map
        default = {
                "ami" = "ami-0277b52859bac6f4b"
                "type"  = "t2.micro"
        }

}
