# terraform

memo:

AWS に以下リソースを一括で作成します

- VPC
- keypair
- security-zone
- instance
- s3 bucket

```screen
cd ./proiders/aws

export AWS_ACCESS_KEY_ID="anaccesskey"
export AWS_SECRET_ACCESS_KEY="asecretkey"
export AWS_DEFAULT_REGION="us-west-2"

terraform init
terraform plan
terraform apply
```