/*
  Resource : 로그인 키
  ncloud 내에서 최초 ssh 비밀번호를 조회하기 위해 사용되는 인증키를 의미합니다.
  terraform apply 를 수행한 환경에 {terraform_name}.pem 이름으로 생성되어 저장됩니다.
*/

resource "ncloud_login_key" "loginkey" {
  key_name = "${var.terraform_name}-key"
}

resource "local_file" "develop_pem" {
  content  = ncloud_login_key.loginkey.private_key
  filename = "${var.terraform_name}.pem"
}

/*
  Resource : Public IP
  공인 IP를 public 서버에 할당합니다. 
*/

resource "ncloud_public_ip" "public_ip" {
  server_instance_no = ncloud_server.public-server.id
}

/*
  Resource : Server
  생성한 vpc, subnet, login_key, nic 리소스들을 할당하여 서버를 생성합니다.
*/
resource "ncloud_server" "public-server" {
  subnet_no                 = ncloud_subnet.public.id
  name                      = "${var.terraform_name}-public-server"
  server_image_number       = "23214590" // ubuntu-22.04
  server_spec_code          = "c2-g3"
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
    network_interface_no = ncloud_network_interface.public_nic.id
    order                = 0
  }
}

resource "ncloud_server" "private-server" {
  subnet_no                 = ncloud_subnet.private.id
  name                      = "${var.terraform_name}-private-server"
  server_image_number       = "23214590" // ubuntu-22.04
  server_spec_code          = "c2-g3" // High CPU & vCPU 2EA, Memory 4GB, Disk 50GB
  login_key_name            = ncloud_login_key.loginkey.key_name
  network_interface {
        network_interface_no = ncloud_network_interface.private_nic.id
        order                = 0
  }
}