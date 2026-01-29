variable "common_tags" {
    type = map
    default = {
        terraform = "true"
        component = "app_alb"
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