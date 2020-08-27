variable "key_name" {
  type        = string
  description = "The name for ssh key, used for aws_launch_configuration. It must be an existing key within your account"
}

variable "intance_min" {
  type        = number
  description = "Mininum number of instances"
}

variable "intance_max" {
  type        = number
  description = "Maximum number of instances"
}

variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
}

variable "username" {
  type        = string
  description = "jenkins username"
}
variable "password" {
  type        = string
  description = "jenkins password"
}

variable "port" {
  type        = number
  description = "Select port for Jenkins server to run"
  default     = 8080
}
