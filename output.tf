output "webserver-public-ip" {

    value = aws_instance.web.public_ip
}

output "bastion-public-ip" {

    value = aws_instance.ssh.public_ip
}

output "DBserver-private-ip" {

    value = aws_instance.db1.private_ip
}
