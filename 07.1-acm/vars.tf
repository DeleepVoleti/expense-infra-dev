variable "common_tags" {
    type = map
    default = {
        terraform = "true"
        component = "acm"
    }
}

variable "project_name" {
    type = string
    default = "expense"
}

variable "env" {
    type = string
    default = "dev"
}

variable "zone_name" {
    type = string
    default = "dilipswebsite.online"
}

variable "zone_id" {
  default = "Z0821679XSGKNCDWTPZB"
}