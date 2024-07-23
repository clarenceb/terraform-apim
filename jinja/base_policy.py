from jinja2 import Environment, FileSystemLoader
import json
import ipaddress

environment = Environment(loader=FileSystemLoader("templates/"), trim_blocks=True, lstrip_blocks=True)
template = environment.get_template("base_apim_policy.xml.jinja")
output_filename = "base_apim_policy.xml"

with open('akamai_production_cidr_ranges.json') as cidr_ranges:
  cidr_ranges_json = json.load(cidr_ranges)

prod_cidrs = []
for cidr in cidr_ranges_json["networkList"]["list"]:
    if "/" in cidr:
        net = ipaddress.IPv4Network(cidr)
        network_address = str(net.network_address)
        broadcast_address = str(net.broadcast_address)
    else:
        network_address = ""
        broadcast_address = ""

    prod_cidr = {
        "address": cidr,
        "broadcast_address": broadcast_address,
        "network_address": network_address,
        "description": cidr_ranges_json["networkList"]["name"]
    }
    prod_cidrs.append(prod_cidr)

print(json.dumps(prod_cidrs, indent=2))

content = template.render(
    {
        "cidrs": prod_cidrs
    }
)

print(content)

with open(output_filename, mode="w", encoding="utf-8") as message:
    message.write(content)

