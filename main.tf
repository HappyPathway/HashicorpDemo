# manage Github users and OnCall Rotations
module "service_config" {
  source = "git@github.com:HappyPathway/ServiceConfig.git"
  admins = "${var.admins}"
  devs = "${var.devs}"
  repo = "${var.repo}"
  nightshift_users = "${var.nightshift_users}"
  dayshift_users = "${var.dayshift_users}"
  setup = "${var.setup_services}"
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

module "app_Alpha" {
  source = "git@github.com:HappyPathway/AwsConsulApp.git"
  count = "${var.app_instances}"
  service_version = "${var.alpha_version}"
  env = "${var.env}"
  service_name = "${var.service_name}"
  service_healthcheck = "/"
  region = "${var.region}"
  server_pool = "alpha"
}

module "app_Bravo" {
  source = "git@github.com:HappyPathway/AwsConsulApp.git"
  count = "${var.app_instances}"
  service_version = "${var.bravo_version}"
  env = "${var.env}"
  service_name = "${var.service_name}"
  service_healthcheck = "/"
  region = "${var.region}"
  server_pool = "bravo"
}

