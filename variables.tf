variable "repo" {}
variable "env" {
  default = "staging"
}
variable "service_name" {}
variable "proxy_service_name" {}
variable "proxy_version" {}
variable "proxy_name" {}

variable "devs" {
    type = "list"
}

variable "admins" {
    type = "list"
}


variable "deployment_version" {}
variable "alpha_version" {}
variable "bravo_version" {}

variable "region" {
    default = "us-east-1"
}

variable "app_instances" {
    default = 2
}

variable "dayshift_users" {
    type = "list"
}

variable "nightshift_users" {
    type = "list"
}
