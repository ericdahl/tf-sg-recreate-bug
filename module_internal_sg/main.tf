variable "vpc_id" {}

variable "sgs" {
  type = "map"
}

resource "aws_security_group" "default" {
  vpc_id = "${var.vpc_id}"
}


resource "aws_security_group_rule" "ingress" {
  from_port = 80
  protocol = "tcp"
  security_group_id = "${aws_security_group.default.id}"
  to_port = 80
  type = "ingress"
  source_security_group_id = "${lookup(var.sgs["public"], "load_balancer")}"
}

output "sg_ids" {
  value = {
    sg_id = "${aws_security_group.default.id}"
  }
}


