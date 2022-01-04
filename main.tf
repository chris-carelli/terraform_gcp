provider "google" {
    credentials = file("prj-it-sbx-nane1-01-ee937d7c1059.json")
    project = var.gcp_project
    region = var.gcp_region
    zone = var.gcp_zone 
}

terraform {
  backend "gcs" {
    bucket = "terraform831_bucket"
    prefix = "terraform1"
    credentials = "prj-it-sbx-nane1-01-ee937d7c1059.json"
   }
}
