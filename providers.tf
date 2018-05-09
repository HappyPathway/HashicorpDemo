# The variables in this file are being set through environment variables
provider "github" {
  token        = "${var.github_token}"
  organization = "${var.github_organization}"
}

provider "pagerduty" {
  token = "${var.pagerduty_token}"
}