output "proxy" {
  value = "${module.proxy.ip_addresses}"
}

output "apps_v100" {
  value = "${module.app_v100.ip_addresses}"
}

output "apps_v101" {
  value = "${module.app_v101.ip_addresses}"
}