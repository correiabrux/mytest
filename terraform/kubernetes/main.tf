provider "aws" {
  profile                 = "default"
  shared_credentials_file = "~/.aws/config"
  region                  = "${var.region}"
}

# Do not possible to use variable in this block
terraform {
  required_version = ">= 0.11.7"

  backend "s3" {
    bucket = "terraform-state-kuberntes"
    key    = "kubernetes/terraform.tfstate"
    region = "us-east-1"
  }
}

module "key_pair" {
  source     = "../modules/key_pair"
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

module "vpc" {
  source = "../modules/vpc"
  cidr   = "${var.cidr}"

  tags = {
    Name = "${lookup(var.tags, "Name")}"
    Env  = "${lookup(var.tags, "Env")}"
  }
}

module "subnet" {
  source = "../modules/subnet"
  cidr   = "${var.cidr}"
  vpc_id = "${module.vpc.aws_vpc_id}"

  tags = {
    Name = "${lookup(var.tags, "Name")}"
    Env  = "${lookup(var.tags, "Env")}"
  }
}

module "vpc_ig" {
  source = "../modules/vpc_ig"
  vpc_id = "${module.vpc.aws_vpc_id}"

  tags = {
    Name = "${lookup(var.tags, "Name")}"
    Env  = "${lookup(var.tags, "Env")}"
  }
}

module "route_table" {
  source     = "../modules/route_table"
  vpc_id     = "${module.vpc.aws_vpc_id}"
  gateway_id = "${module.vpc_ig.aws_internet_gateway}"

  tags = {
    Name = "${lookup(var.tags, "Name")}"
    Env  = "${lookup(var.tags, "Env")}"
  }
}

module "security_group" {
  source    = "../modules/security_group"
  sgname    = "${var.sgname}"
  vpc_id    = "${module.vpc.aws_vpc_id}"
  from_port = "${var.from_port}"
  to_port   = "${var.to_port}"

  tags = {
    Name = "${lookup(var.tags, "Name")}"
    Env  = "${lookup(var.tags, "Env")}"
  }
}

module "route_table_association" {
  source         = "../modules/route_table_association"
  vpc_id         = "${module.vpc.aws_vpc_id}"
  route_table_id = "${module.route_table.route_table_id}"
}

module "ec2" {
  source        = "../modules/ec2"
  ami           = "${var.ami}"
  sg            = "${module.security_group.sg_id}"
  instance_type = "${var.instance_type}"
  subnet_id     = "${module.subnet.aws_subnet}"
  key_name      = "${module.key_pair.aws_keypair_name}"

  tags = {
    Name = "${lookup(var.tags, "Name")}"
    Env  = "${lookup(var.tags, "Env")}"
  }
}
