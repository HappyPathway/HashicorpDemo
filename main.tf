# manage Github users and OnCall Rotations
module "service_config" {
  source = "git@github.com:HappyPathway/ServiceConfig.git"
  admins = "${var.admins}"
  devs = "${var.devs}"
  repo = "${var.repo}"
  nightshift_users = "${var.nightshift_users}"
  dayshift_users = "${var.dayshift_users}"
  pagerduty_token = "${var.pagerduty_token}"
}

module "deployment" {
  source = "git@github.com:HappyPathway/AwsConsulProxy.git//deployment"
  service_name = "${var.proxy_service_name}"
  service_version = "${var.deployment_version}"
  env = "${var.env}"
}

# manage dev environments
module "proxy" {
  source = "git@github.com:HappyPathway/AwsConsulProxy.git"
  count = 1
  proxy_name = "${var.proxy_name}"
  region = "${var.region}"
  service_name = "${var.proxy_service_name}"
  app_name = "${var.service_name}"
  service_version = "${var.proxy_version}"
  service_healthcheck = "/"
  env = "${var.env}"
}

module "app_v100" {
  source = "git@github.com:HappyPathway/AwsConsulApp.git"
  count = "${var.blue_instances}"
  service_version = "${var.blue_version}"
  env = "${var.env}"
  service_name = "${var.service_name}"
  service_healthcheck = "/"
  region = "${var.region}"
}

module "app_v101" {
  source = "git@github.com:HappyPathway/AwsConsulApp.git"
  count = "${var.green_instances}"
  service_version = "${var.green_version}"
  env = "${var.env}"
  service_name = "${var.service_name}"
  service_healthcheck = "/"
  region = "${var.region}"
}

