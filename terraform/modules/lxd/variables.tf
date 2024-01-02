# PROVIDER VARIABLES
# ------------------

# The name of the LXD provider. This can be a descriptive name for the LXD
# endpoint.
variable "provider_lxd_name" {
  type        = string
  description = "The name of the LXD provider. This can be a descriptive name for the LXD endpoint."
  default     = "endpoint"
}

# The scheme used for the LXD connection. This could be, for example, 'http' or
# 'https'.
variable "provider_lxd_scheme" {
  type        = string
  description = "The scheme used for the LXD connection. This could be, for example, 'http' or 'https'."
  default     = "username"
}

# The address or URL of the LXD server. This includes the hostname or IP address
# and, if applicable, the port number.
variable "provider_lxd_address" {
  type        = string
  description = "The address or URL of the LXD server. This includes the hostname or IP address and, if applicable, the port number."
  default     = "username"
}

# The password used for authentication when connecting to the LXD server.
variable "provider_lxd_password" {
  type        = string
  description = "The password used for authentication when connecting to the LXD server."
  default     = "password"
}

# MODULE VARIABLES - LXD
# ------------------

# The name of the container. This is a user-defined string to identify the LXD container.
variable "container_name" {
  type        = string
  description = "The name of the container. This is a user-defined string to identify the LXD container."
}

# The image for the container. This specifies the image used to create the LXD container.
variable "container_img" {
  type        = string
  description = "The image for the container. This specifies the image used to create the LXD container."
}
