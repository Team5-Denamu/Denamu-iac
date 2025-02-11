# denamu-iac
## 개요
Naver Cloud Platform 을 활용한 인프라 아키텍처를 코드로 관리하기위한 저장소 입니다.

## 사전 설정
### terraform.tfvars
```go
access_key = "NCP API 액세스 키"
secret_key = "NCP API 비밀 키"
```
정상적으로 Ncloud Provider를 활용하기 위해서 NCP 에서 발급받은 액세스, 비밀 키가 필요합니다.