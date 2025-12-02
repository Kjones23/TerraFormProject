variable "app_name" {
  type    = string
  default = "backend"
}

variable "image_name" {
  type    = string
  default = "my-backend"
}

variable "container_port" {
  type    = number
  default = 5000
}

variable "namespace" {
  type    = string
  default = "demo"
}
