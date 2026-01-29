variable "common_tags" {
    type = map
    default = {
        terraform = "true"
        component = "vpc"
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