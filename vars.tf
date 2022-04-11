# Declaring variables.



variable "cidr_mgmt" {
  type = string
  description = "Declaring variable for the cidr of the mgmt subnet"
}


variable "cidr_app" {
  type = string
  description = "Declaring variable for the cidr of the app subnet"
}

variable "project_id" {
  type = string
  description = "Declaring variable for the project id"
}

variable "gcp_region" {
  type = string
  description = "Declaring variable for the gcp region"
}