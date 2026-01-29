variable "common_tags" {
    type = map
    default = {
        terraform = "true"
        component = "web-alb"
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