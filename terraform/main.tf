module "module-a" {
  // source module
  source = "./modules/lxd" 

  // pass provider variables to module 
  provider_lxd_name     = var.provider_lxd_name 
  provider_lxd_scheme   = var.provider_lxd_scheme 
  provider_lxd_address  = var.provider_lxd_address 
  provider_lxd_password = var.provider_lxd.password 

  // pass variables to module
  container_name  = "test"
  container_img   = "ubuntu" 
}
