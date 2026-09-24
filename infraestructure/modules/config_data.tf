data "cloudinit_config" "server_demo" {
  gzip          = false
  base64_encode = true

  dynamic "part" {
    for_each = fileset("${path.module}/scripts", "*.yml")

    content {
      content_type = "text/cloud-config"
      content      = file("${path.module}/scripts/${part.value}")
      filename     = part.value
    }
  }
}
