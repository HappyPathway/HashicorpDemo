terraform {
  backend "s3" {
    bucket = "happypathway-terraform-states"
    key    = "infra/hashicorp"
    region = "us-east-1"
  }
}