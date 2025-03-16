
provider "aws" {
    access_key = ""
    secret_key = ""
    region = "ap-south-1"
}

resource "aws_instance" "terraform-instance" {
    ami= var.ami
    instance_type = var.instance_type
    key_name = var.key_name

    connection {
      type = "ssh"
      private_key = file("key/yashtnaik-instance-3.pem")
      user = "ec2-user"
      agent = false
      host = self.public_ip
    }

    provisioner "file" {
      source      = "k8s_installer.sh "
      destination = "/home/k8s_installer.sh"
  }

    provisioner "remote-exec" {
        inline = [ "sudo apt update",
         "curl -s https://raw.githubusercontent.com/jaintpharsha/install/main/k8s/cluster_setup_using_kubeadm_new.sh?node_type=${var.node_type} | bash -s" ]

    }

}


