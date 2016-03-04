Basic Terraform Demo

You will need a terraform.tfvars file containing access keys for aws_provider variables

Next, you can pass in the variable file

terraform plan -var-file terraform.tfvars
terraform apply -var-file terraform.tfvars
