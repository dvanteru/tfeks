locals {
  # The name of this module. This is a special variable
  module = "k8s"

  # Compound Scope Identifier
  csi = replace(
    format(
      "%s-%s-%s-%s",
      var.project,
      var.environment,
      var.component,
      local.module,
    ),
    "_",
    "-",
  )

  # CSI for resources in the global namespace, e.g. S3 Buckets
  cis_global = replace(
    format(
      "%s-%s-%s-%s-%s-%s",
      var.project,
      var.aws_account_id,
      var.region,
      var.environment,
      var.component,
      local.module,
    ),
    "_",
    "-",
  )

  default_tags = merge(
    var.default_tags,
    {
      Module = local.module
    }
  )

  wait_for_cluster_interpreter = ["/bin/sh", "-c"]
  wait_for_cluster_cmd         = "for i in `seq 1 30`; do if `command -v wget > /dev/null`; then wget --tries=1 --timeout=5 --no-check-certificate -O - -q $ENDPOINT/healthz >/dev/null && exit 0 || true; else curl --max-time 5 --retry 1 -k -s $ENDPOINT/healthz >/dev/null && exit 0 || true;fi; sleep 5; done; echo TIMEOUT && exit 1"
}
