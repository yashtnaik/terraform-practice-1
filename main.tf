provider "aws" {
    access_key = ""
    secret_key = ""
    region = "ap-south-1"
}

resource "aws_instance" "terraform-instance" {
    ami= var.ami
    instance_type = var.instance_type
    key_name = var.key_name
}

