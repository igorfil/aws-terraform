variable "azs" {
  type = list(string)
  default = ["us-west-2c", "us-west-2d"]
}

variable "instance_count" {
  type = number
  default = 3
}

resource "aws_instance" "webapp" {
  count = var.instance_count
  ami = "ami-0518bb0e75d3619ca"
  instance_type = "t2.micro"
  availability_zone = var.azs[count.index % length(var.azs)]
  vpc_security_group_ids = ["sg-0a9a9dca6efc2f0ce"]

  user_data = <<END
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    sudo chown -R ec2-user:apache /var/www
    cd /var/www/html
    echo "Instance ${count.index}" >> index.html"
END
}
