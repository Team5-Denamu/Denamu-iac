# denamu-iac
## 개요
Naver Cloud Platform 및 AWS를 활용한 인프라 아키텍처를 코드로 관리하기위한 저장소 입니다.

## 사전 설정
### terraform.tfvars
```go
{플랫폼 명}_access_key = "API 액세스 키"
{플랫폼 명}_secret_key = "API 비밀 키"
```
정상적으로 Provider를 활용하기 위해서 각 플랫폼 에서 발급받은 액세스, 비밀 키가 필요합니다.