## For SSH server (Bastion)

resource "aws_security_group" "ssh" {
    
    name        = "${var.project}-ssh"
    description =  "Allow SSH from everyone"
    vpc_id      =  aws_vpc.vpc.id

    ingress {
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = [ "::/0" ]
    }

    egress {

        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = [ "::/0" ] 
    }

    tags = {
    Name = "${var.project}-ssh"
  }

  lifecycle {
    create_before_destroy = true
  }
}


## For webserver 

resource "aws_security_group" "web" {
    
    name        = "${var.project}-web"
    description =  "web from all & ssh from Bastion"
    vpc_id      =  aws_vpc.vpc.id

    ingress {
        from_port           = 80
        to_port             = 80
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = [ "::/0" ]
    }

    ingress {
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        security_groups      = [aws_security_group.ssh.id]
    }

      ingress {
        from_port           = 443
        to_port             = 443
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = [ "::/0" ]
    }

    egress {

        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
        ipv6_cidr_blocks    = [ "::/0" ] 
    }

    tags = {
    Name = "${var.project}-web"
  }

  lifecycle {
    create_before_destroy = true
  }
}


## For Database

resource "aws_security_group" "db" {
    
    name        = "${var.project}-database"
    description =  "Db from webserver & ssh from Bastion"
    vpc_id      =  aws_vpc.vpc.id

    ingress {
        from_port           = 3306
        to_port             = 3306
        protocol            = "tcp"
        security_groups      = [aws_security_group.web.id]
    }

    ingress {
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        security_groups      = [aws_security_group.ssh.id]
    }

      
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }

    tags = {
    Name = "${var.project}-database"
  }
lifecycle {
    create_before_destroy = true
  }

}
