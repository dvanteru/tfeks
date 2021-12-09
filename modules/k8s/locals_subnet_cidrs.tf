locals {
  control_plane_subnet_cidrs = [
    cidrsubnet(
      var.vpc_cidr,
      var.control_plane_subnets["subnets_newbits"],
      var.control_plane_subnets["subnets_netnum_root"],
    ),
    cidrsubnet(
      var.vpc_cidr,
      var.control_plane_subnets["subnets_newbits"],
      var.control_plane_subnets["subnets_netnum_root"] + 1,
    ),
    cidrsubnet(
      var.vpc_cidr,
      var.control_plane_subnets["subnets_newbits"],
      var.control_plane_subnets["subnets_netnum_root"] + 2,
    ),
  ]

  worker_node_subnet_cidrs = [
    cidrsubnet(
      var.vpc_cidr,
      var.worker_node_subnets["subnets_newbits"],
      var.worker_node_subnets["subnets_netnum_root"],
    ),
    cidrsubnet(
      var.vpc_cidr,
      var.worker_node_subnets["subnets_newbits"],
      var.worker_node_subnets["subnets_netnum_root"] + 1,
    ),
    cidrsubnet(
      var.vpc_cidr,
      var.worker_node_subnets["subnets_newbits"],
      var.worker_node_subnets["subnets_netnum_root"] + 2,
    ),
  ]

  private_lb_subnet_cidrs = [
    cidrsubnet(
      var.vpc_cidr,
      var.private_lb_subnets["subnets_newbits"],
      var.private_lb_subnets["subnets_netnum_root"],
    ),
    cidrsubnet(
      var.vpc_cidr,
      var.private_lb_subnets["subnets_newbits"],
      var.private_lb_subnets["subnets_netnum_root"] + 1,
    ),
    cidrsubnet(
      var.vpc_cidr,
      var.private_lb_subnets["subnets_newbits"],
      var.private_lb_subnets["subnets_netnum_root"] + 2,
    ),
  ]
}