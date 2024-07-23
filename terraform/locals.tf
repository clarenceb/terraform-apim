locals {
    cidr_ranges = jsondecode(file("${path.module}/policies/akamai_production_cidr_ranges.json"))

    prod_cidrs = flatten([
        for cidr in local.cidr_ranges.networkList.list : {
            address = cidr
            description = local.cidr_ranges.networkList.description
            network_address = strcontains(cidr, "/") ? cidrhost(cidr, 0) : ""
            broadcast_address = strcontains(cidr, "/") ? cidrhost(cidr, -1) : ""
        }
    ])
}
