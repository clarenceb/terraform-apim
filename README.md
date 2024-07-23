# Azure API Management Dynamic Policies

## Steps

```sh
cd terraform/
terraform init -upgrade
terraform plan -out main.tfplan
terraform apply main.tfplan
```

## Debugging Terraform expressions and templates

```sh
terraform console
```

Now you can check variables and rendered template outputs:

```hcl
local.cidr_ranges

local.prod_cidrs

templatefile("${path.module}/policies/base_apim_policy.xml.tftpl", { cidrs = local.prod_cidrs })
```

## Alternative way to render templates with Jinja

```sh
cd jinja2/

sudo apt install python3-venv
sudo apt install python3-pip
python3 -m venv .venv

source .venv/bin/activate
python -V

pip install jinja2
rm -f base_apim_policy.xml

python base_policy.py
cat base_apim_policy.xml
```

## Resources

* [Terraform `azurerm_api_management` resource](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management)
* [Dynamic Azure API Management Policies](https://github.com/Azure-Samples/dynamic-apim-policies)
* [Terraform Language Documentation](https://developer.hashicorp.com/terraform/language)
* [`cidrhost` function](https://developer.hashicorp.com/terraform/language/functions/cidrhost)
* [`terraform console`](https://developer.hashicorp.com/terraform/cli/commands/console)
* [Jinja templating engine](https://jinja.palletsprojects.com/en/3.0.x/intro/)

## TODO

* Team development for apis and api policies
