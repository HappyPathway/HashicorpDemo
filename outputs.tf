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

output "beta_dns" {
  value = "${module.app_Beta.dns}"
}

output "beta_dns_nodes" {
  value = "${module.app_Beta.dns_nodes}"
}