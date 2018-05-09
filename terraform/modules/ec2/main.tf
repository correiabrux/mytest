resource "aws_instance" "main" {
  ami                         = "${var.ami}"
  security_groups             = ["${var.sg}"]
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.subnet_id}"
  associate_public_ip_address = true
  key_name                    = "${var.key_name}"
  private_ip                  = "${var.private_ip}"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt-get install ansible python -y
              git clone https://github.com/correiabrux/mytest.git
              ansible-playbook -i "localhost," -c local /mytest/ansible/k8s-wordpress/site.yml
              EOF

  tags = {
    Name = "${lookup(var.tags, "Name")}"
    Env  = "${lookup(var.tags, "Env")}"
  }
}
