output "proxy" {
  value = "${module.proxy.ip_addresses}"
}

output "apps_Alpha" {
  value = "${module.app_Alpha.ip_addresses}"
}

output "apps_Bravo" {
  value = "${module.app_Bravo.ip_addresses}"
}