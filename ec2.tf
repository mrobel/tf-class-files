# Test SG
resource "aws_security_group" "ibm_app_sg" {
  name = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.ibm.id

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_app"
  }
}



# Launch Instance
resource "aws_instance" "ibm_instance" {
  ami           = "ami-0e472ba40eb589f49" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.ibm_pub_sb.id
  key_name      = "virginie-robel"
  count = 2
  vpc_security_group_ids = [ aws_security_group.ibm_app_sg.id ]
  user_data = file("ecomm.sh")
}
