terraform {
  backend "s3" {
    bucket = "happypathway-terraform-states"
    key    = "infra/hashicorp-demo2"
    region = "us-east-1"
  }
}
