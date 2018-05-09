variable "tags" {
  type = "map"

  default = {
    "Name" = "Kubernetes"
    "Env"  = "Prod"
  }
}

variable "cidr" {
  default = "10.20.0.0/24"
}

variable "region" {
  default = "us-east-1"
}

variable "from_port" {
  default = "80"
}

variable "to_port" {
  default = "80"
}

variable "sgname" {
  default = "kubernetes"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-43a15f3e"
}

variable "key_name" {
  default = "mykey"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvnKd2KrsmdqhlkrnFgAV96Rsp9agIEbnVKgmGGIB6iSDGeVCm0vABboGaRtTGnfTSpZWqcG7B3fqCt/bu8cOyAlF9oMkDS6mg9fnX3GdHyZ5CQ9/t1zlGj1Q7j8XL4Qbl/BZnQEm8O25VRFJdAHFekRFM2M1NXU9o/MOsgDdpM1XxcV5k0L/CNubd0sPjY6N6h5UaZonKCgglMhsGSH90wr0A4FqiZjaGnZBarF0UgUQ2utuD0CBWz/xRHUdBlhn4oU+Blcg/m1E3DvKNBNVltIt0NS4r75rP51vr7I64pw38q4yNhQRCIiQnvueVtQhxOK//xiZwmUgDyg8g/J4R"
}
