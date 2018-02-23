Test case illustrating unusual Terraform behavior, seen with TF 0.11.2

# Reproduce Steps

0. Set variable for VPC

```
$ echo 'vpc_id="vpc12345"' > terraform.tfvars

```

1. Terraform apply

```bash
$ terraform init
$ terraform apply -auto-approve
```

2. Uncomment the lines from `module_public_sg/main.tf`

```bash
$ $EDITOR module_public_sg/main.tf
```

3. Terraform plan. Observe that TF is going to destroy/recreate a security group rule that should
have no modifications
```bash
$ terraform plan
Terraform will perform the following actions:

  + module.module_public_sg.aws_security_group.tmp
      id:                       <computed>
      description:              "Managed by Terraform"
      egress.#:                 <computed>
      ingress.#:                <computed>
      name:                     <computed>
      owner_id:                 <computed>
      revoke_rules_on_delete:   "false"
      vpc_id:                   <computed>

-/+ module.module_two.aws_security_group_rule.ingress (new resource required)
      id:                       "sgrule-1901278503" => <computed> (forces new resource)
      from_port:                "80" => "80"
      protocol:                 "tcp" => "tcp"
      security_group_id:        "sg-ad2626da" => "sg-ad2626da"
      self:                     "false" => "false"
      source_security_group_id: "sg-951c1ce2" => "${lookup(var.sgs[\"public\"], \"load_balancer\")}" (forces new resource)
      to_port:                  "80" => "80"
      type:                     "ingress" => "ingress"


Plan: 2 to add, 0 to change, 1 to destroy.

```
