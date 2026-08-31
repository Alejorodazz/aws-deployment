data "cloudinit_config" "servidor_config" {
  gzip          = false
  base64_encode = true

  dynamic "part" {
    for_each = fileset("${path.module}/scripts", "*.yaml")
    
    content {
      content_type = "text/cloud-config"
      content      = file("${path.module}/scripts/${part.value}")
      filename     = part.value
    }
  }
}