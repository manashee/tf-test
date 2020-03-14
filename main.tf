provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/Users/ashokkumar/.aws/credentials"
}
variable "server_port" {
  default = 8080
  description = "the port of the webserver"
}

output "public_ip" {
  value = "${aws_instance.ec2-test.public_ip}"
}

resource "aws_instance" "ec2-test" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"

  vpc_security_group_ids = ["${aws_security_group.ec2-test-sec.id}"]
  user_data = <<-EOF
            #!/bin/bash
            echo "hello world" > index.html
            nohup busybox httpd -f -p "${var.server_port}" &
            EOF

  tags = {
    Name = "ashok"
  }
}

resource "aws_security_group" "ec2-test-sec" {
  name = "ec2-test-sec-grp"
  ingress {
   from_port = "${var.server_port}"
   to_port = "${var.server_port}"
   cidr_blocks = ["0.0.0.0/0"]
   protocol = "tcp"
  } 
  
   
}
