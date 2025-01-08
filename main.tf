 provider "aws" {
  region = "eu-west-1"
}

resource "aws_ecs_cluster" "kuma_cluster" {
  name = "kuma-cluster"
}
