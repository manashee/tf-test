provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/Users/ashokkumar/.aws/credentials"
}

resource "aws_instance" "ec2-test" {
  ami = "ami-40d28157"
  instance_type = "t2.micro"

  user_data = <<-EOF
            #!/bin/bash
            echo "hello world" > index.html
            nohup busybox - f - p 8080 &
            EOF

  tags = {
    Name = "ashok"
  }
}
