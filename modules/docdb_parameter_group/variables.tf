variable "name" {
  type = string
}

variable "family" {
  type = string
}

variable "description" {
  type = string
}

variable "parameters" {
  type        = list(map(string))
  default     = []
  description = "List of DB parameters to apply"
}

variable "create" {
  type    = bool
  default = false
}
