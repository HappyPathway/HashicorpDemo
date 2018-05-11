output "proxy" {
  value = "${module.proxy.ip_addresses}"
}

output "apps_Alpha" {
  value = "${module.app_Alpha.ip_addresses}"
}

output "apps_Bravo" {
  value = "${module.app_Bravo.ip_addresses}"
}

output "proxy_host" {
  value = "${module.proxy.dns}"
}

output "alpha_dns" {
  value = "${module.app_Alpha.dns}"
}

output "alpha_dns_nodes" {
  value = "${module.app_Alpha.dns_nodes}"
}

output "bravo_dns" {
  value = "${module.app_Bravo.dns}"
}

output "bravo_dns_nodes" {
  value = "${module.app_Bravo.dns_nodes}"
}