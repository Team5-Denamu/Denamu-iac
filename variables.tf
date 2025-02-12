variable "access_key" {
  description = "NCP access_key"
  type        = string
}

variable "secret_key" {
  description = "NCP secret_key"
  type        = string
}

variable "region" {
  description = "NCP region"
  type        = string
  default     = "KR"
}

variable "site" {
  description = "NCP site"
  default     = "public"
}

variable "support_vpc" {
  description = "NCP support vpc"
  default     = "true"
}

variable "zones" {
  default = "KR-1"
}

variable "zone_name" {
  default = "kr1"
}

variable "terraform_name" {
  default = "tf-denamu"
}