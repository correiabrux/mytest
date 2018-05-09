output "aws_vpc" {
  value = "${module.vpc.aws_vpc_id}"
}

output "aws_subnet" {
  value = "${module.subnet.aws_subnet}"
}

output "aws_instance" {
  value = "${module.ec2.aws_instance_id}"
}


output "aws_internet_gateway" {
  value = "${module.vpc_ig.aws_internet_gateway}"
}


output "aws_ec2" {
  value = "${module.ec2.public_ip}"
}
