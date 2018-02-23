variable "vpc_id" {}

resource "aws_security_group" "default" {
  vpc_id = "${var.vpc_id}"
}

output "sg_ids" {
  value = {
    load_balancer = "${aws_security_group.default.id}"

    // Uncomment below line and its resource
//    foo = "${aws_security_group.tmp.id}"
  }
}

//resource "aws_security_group" "tmp" {}
//
