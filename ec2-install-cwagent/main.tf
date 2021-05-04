data template_file "cw-install" {

}

resource "aws_instance" "ec2-example" {
  ami           = "ami-041a1e420403dfe70"
  instance_type = "t2.micro"
  user_data = data.template_file.cw-install.rendered
}

output "ip" {

value=aws_instance-example.public_ip

}