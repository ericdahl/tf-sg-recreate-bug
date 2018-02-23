provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {}

module "module_public_sg" {
  source = "module_public_sg"
  vpc_id = "${var.vpc_id}"
}

module "module_two" {
  source = "module_internal_sg"
  vpc_id = "${var.vpc_id}"

  sgs = {
    public = "${module.module_public_sg.sg_ids}"
  }

}

