variable "create" {
  type    = bool
  default = false
}

variable "name" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "description" {
  type = string
}

variable "name_prefix" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add to all resources"
}
