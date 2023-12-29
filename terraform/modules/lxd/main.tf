resource "lxd_container" "container" {
  name      = var.container_name 
  image     = var.container_img 

  ephemeral = false

  config = {
    "boot.autostart" = true
  }

  limits = {
    cpu = 2
  }
}
