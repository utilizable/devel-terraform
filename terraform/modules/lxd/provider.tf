provider "lxd" {
  generate_client_certificates = true
  accept_remote_certificate    = true

  lxd_remote {
    name     = var.provider_lxd_name 
    scheme   = var.provider_lxd_scheme 
    address  = var.provider_lxd_address 
    password = var.provider_lxd.password 
    default  = true
  }
}

