provider "aws" {
  region = "eu-central-1"
}
resource "aws_instance" "my_example" {
  ami           = "ami-09633db638556dc39"
  instance_type = "t2.micro"
  tags = {
      Name = "terraform-my-example"
  }
}