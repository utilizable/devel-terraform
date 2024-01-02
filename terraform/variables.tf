# PROVIDER VARIABLES
# ------------------

variable "provider_lxd_name" {
  type        = string
  description = "The name of the LXD provider. This can be a descriptive name for the LXD endpoint."
  default     = "endpoint"
}

variable "provider_lxd_scheme" {
  type        = string
  description = "The scheme used for the LXD connection. This could be, for example, 'http' or 'https'."
  default     = "username"
}

variable "provider_lxd_address" {
  type        = string
  description = "The address or URL of the LXD server. This includes the hostname or IP address and, if applicable, the port number."
  default     = "username"
}

variable "provider_lxd_password" {
  type        = string
  description = "The password used for authentication when connecting to the LXD server."
  default     = "password"
}
