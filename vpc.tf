# Resource : VPC 리소스
resource "ncloud_vpc" "main" {
    name = "${var.terraform_name}-vpf-tf"
    ipv4_cidr_block = "172.16.0.0/24"
}

# Resource : 서브넷 리소스 (Public)
resource "ncloud_subnet" "public" {
    name = "${var.terraform_name}-sbn-public"
    vpc_no = ncloud_vpc.main.id
    subnet = cidrsubnet(ncloud_vpc.main.ipv4_cidr_block, 4, 0) # 172.16.0.0/28
    zone = var.zones
    network_acl_no = ncloud_vpc.main.default_network_acl_no
    subnet_type = "PUBLIC"
}

# Resource : 서브넷 리소스 (Private) (미사용으로 인해 제거)
# resource "ncloud_subnet" "private" {
#     name = "${var.terraform_name}-sbn-private"
#     vpc_no = ncloud_vpc.main.id
#     subnet = cidrsubnet(ncloud_vpc.main.ipv4_cidr_block, 4, 1) # 172.16.0.16/28
#     zone = var.zones
#     network_acl_no = ncloud_vpc.main.default_network_acl_no
#     subnet_type = "PRIVATE"
# }

# Resource : 라우트 테이블 리소스 (Public)
# Detail : 라우트 테이블은 기본적으로 생성되기에, 별도의 NAT 설정이 추가적으로 필요하지 않은 이상 사용하지 않아도 무관하여 주석처리 하였습니다.

# resource "ncloud_route_table" "route_table_public" {
#     vpc_no = ncloud_vpc.main.id
#     name = "rt-tf-public"
#     description = "Public Route Table with Terraform"
#     supported_subnet_type = "PUBLIC"
# }

# resource "ncloud_route_table" "route_table_private" {
#     vpc_no = ncloud_vpc.main.id
#     name = "rt-tf-private"
#     description = "Private Route Table with Terraform"
#     supported_subnet_type = "PRIVATE"
# }

# resource "ncloud_route_table_association" "rt_subnet_association_public" {
#     route_table_no = ncloud_route_table.route_table_public.id
#     subnet_no = ncloud_subnet.public.id
# }

# resource "ncloud_route_table_association" "rt_subnet_association_private" {
#     route_table_no = ncloud_route_table.route_table_private.id
#     subnet_no = ncloud_subnet.private.id
# }
