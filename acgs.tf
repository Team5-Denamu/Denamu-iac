/*
  Resource : Public 서버 ACG
  Public Server 및 Private Server에 사용되는 ACG(Access Control Group)을 정의합니다.
  group_rule에는 인 바운드 및 아웃 바운드가 정의됩니다.
*/

resource "ncloud_access_control_group" "tf_public_acg" {
  name   = "${var.zone_name}-${var.terraform_name}-public-acg"
  vpc_no = ncloud_vpc.main.id
}

resource "ncloud_access_control_group_rule" "tf_public_acg_rule" {
  access_control_group_no = ncloud_access_control_group.tf_public_acg.id
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "SSH"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
    description = "HTTP"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "443"
    description = "HTTPS"
  }
  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }
  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }
  outbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
  }
}

# 미사용으로 인해 제거
# resource "ncloud_access_control_group" "tf_private_acg" {
#   name   = "${var.zone_name}-${var.terraform_name}-private-acg"
#   vpc_no = ncloud_vpc.main.id
# }

# resource "ncloud_access_control_group_rule" "tf_private_acg_rule" {
#   access_control_group_no = ncloud_access_control_group.tf_private_acg.id
#   inbound {
#     protocol    = "TCP"
#     ip_block    = "0.0.0.0/0"
#     port_range  = "22"
#     description = "SSH"
#   }
#   inbound {
#     protocol    = "TCP"
#     ip_block    = "0.0.0.0/0"
#     port_range  = "8080"
#     description = "WAS"
#   }
#   inbound {
#     protocol    = "TCP"
#     ip_block    = "0.0.0.0/0"
#     port_range  = "80"
#     description = "HTTP"
#   }
#   inbound {
#     protocol    = "TCP"
#     ip_block    = "0.0.0.0/0"
#     port_range  = "443"
#     description = "HTTPS"
#   }
#   outbound {
#     protocol    = "TCP"
#     ip_block    = "0.0.0.0/0"
#     port_range  = "1-65535"
#   }
#   outbound {
#     protocol    = "UDP"
#     ip_block    = "0.0.0.0/0"
#     port_range  = "1-65535"
#   }
#   outbound {
#     protocol    = "ICMP"
#     ip_block    = "0.0.0.0/0"
#   }
# }

/*
  Resource : NIC
  작성한 ACG를 NIC에 적용시켜 서버에 할당합니다.
*/

resource "ncloud_network_interface" "public_nic" {
  name = "${var.terraform_name}-public-nic"
  subnet_no = ncloud_subnet.public.id
  access_control_groups = [ncloud_access_control_group.tf_public_acg.id]
}

# 미사용으로 인해 제거
# resource "ncloud_network_interface" "private_nic" {
#   name = "${var.terraform_name}-private-nic"
#   subnet_no = ncloud_subnet.private.id
#   access_control_groups = [ncloud_access_control_group.tf_private_acg.id]
# }