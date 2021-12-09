data "archive_file" "main" {
  type        = "zip"
  output_path = local.archive_path

  source {
    content  = "${var.function_source}"
    filename = "${var.function_module_name}.${var.function_file_extension}"
  }
}
