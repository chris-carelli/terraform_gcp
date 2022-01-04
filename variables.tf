variable "gcp_project" {
  default = "prj-it-sbx-nane1-01"
}

variable "gcp_prefix" {
  default = "prj-it-sbx-nane1-chris"
}

variable "gcp_region" {
  default = "northamerica-northeast1" 
}

variable "gcp_zone" {
  default = "northamerica-northeast1-a" 
}

variable "adminSrcAddr" {
  default = "10.86.0.0/16"
}
  
variable "gcp_cidr_mgmt" {
  default = "10.83.23.0/24"
}

variable "gcp_cidr_int" {
  default = "10.84.10.0/24"
}

variable "gcp_cidr_lb" {
  default = "10.84.20.0/24"
}

variable "gcp_vpc" {
  default = "vpc-it-l3test-nane1-01"
}

variable "l3test_as" {
  default = "prj-it-sbx-autoscaler"
}

variable "l3test_it" {
  default = "prj-it-sbx-instance-template"
}

variable "l3test_tp" {
  default = "prj-it-sbx-target-pool"
}

variable "l3test_igm" {
  default = "prj-it-sbx-igm"
}

variable "purpose" {
  default = "internal"
}

variable "environment" {
  default = "f5env"
}

variable "owner" {
  default = "f5owner"
}

variable "group" {
  default = "f5group"
}

variable "costcenter" {
  default = "f5costcenter"
}

variable "application" {
  default = "f5app"
}

variable "f5_cloud_failover_label" {
  default = "icn_f5_deployment"
}
