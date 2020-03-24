# first we create provider for this part of infrastructure
provider "aws" {
  region = "eu-central-1"
}
# then we start creating resources
resource "aws_instance" "my_example" {
  ami           = "ami-09633db638556dc39"
  instance_type = "t2.micro"
  user_data = <<-EOF
            #!/bin/bash
            echo "Hello, World" > index.html
            nohup busybox httpd -f -p 8080 &
            EOF
  tags = {
      Name = "terraform-my-example"
  }
  vpc_security_group_ids = [aws_security_group.instance.id]
}
# for the web server we need to create firewall rules, so we create security group resource
resource "aws_security_group" "instance" {
    name = "terraform-example-instance"
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


#expressions
# - reference: <PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE> they are used to refference other resources to existing ones, usually by id
# command - terraform graph - gives output that can be drawn here GraphvizOnline - http://bit.ly/2mPbxmg
