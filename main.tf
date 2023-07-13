
resource "aws_instance" "nano" {
    ami = "ami-0261755bbcb8c4a84"
    instance_type = "t2.medium"
    vpc_security_group_ids = [aws_security_group.sec-grp.id]
    key_name = "Key_Pair"

    tags = {
      Name = "medium"
    }

}


resource "aws_security_group" "sec-grp" {
    name = "Sec-Grp"
    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "SEC-GRP"
    }
  
}

resource "tls_private_key" "PK" {
    algorithm = "RSA"
    rsa_bits = 2048
}


resource "local_file" "Lf" {
    content = tls_private_key.PK.private_key_pem
    filename = "tfkey"
}

resource "aws_key_pair" "Key_Pair" {
    key_name = "Key_Pair"
    public_key = tls_private_key.PK.public_key_openssh
  
}
