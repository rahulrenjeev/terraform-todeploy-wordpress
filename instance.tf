## key pair created

resource "aws_key_pair" "key" {

  key_name      = "${var.project}-keypair"
  public_key    = file("rahul.pub")
  tags = {
    Name = "${var.project}-keypair"
  }

}

## Intance for webserver

resource "aws_instance" "web" {
  ami                           = var.insta.ami
  instance_type                 = var.insta.type
  associate_public_ip_address   = true
  key_name                      = aws_key_pair.key.key_name
  vpc_security_group_ids        = [  aws_security_group.web.id ]
  subnet_id                     = aws_subnet.public1.id
        user_data               = file("apach.sh")
  tags = {
    Name = "${var.project}-webserver"
  }
}

## Intance for SSH

resource "aws_instance" "ssh" {
  ami                           = var.insta.ami
  instance_type                 = var.insta.type
  associate_public_ip_address   = true
  key_name                      = aws_key_pair.key.key_name
  vpc_security_group_ids        = [  aws_security_group.ssh.id ]
  subnet_id                     = aws_subnet.public1.id
user_data                       = file("key.sh")
  tags = {
    Name = "${var.project}-bastion"
  }
}

## Intance for DB server

resource "aws_instance" "db1" {
  ami                           = var.insta.ami
  instance_type                 = var.insta.type
  key_name                      = aws_key_pair.key.key_name
  vpc_security_group_ids        = [  aws_security_group.db.id ]
  subnet_id                     = aws_subnet.private1.id
        private_ip = "172.16.97.0"

user_data       = file("database.sh")
  tags = {
    Name = "${var.project}-database"
  }
}
