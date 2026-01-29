variable "common_tags" {
    type = map
    default = {
        terraform = "true"
        component = "open-vpn"
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

variable "sg_name" {
    type = string
    default = ""
}