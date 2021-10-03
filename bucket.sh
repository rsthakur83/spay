#!/bin/bash
sudo wget https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip
sudo apt-get update; apt-get install awscli unzip -y
sudo unzip terraform_0.12.0_linux_amd64.zip
chmod +x terraform
mkdir /root/.aws/
echo "[default]"  >> /root/.aws/credentials
cd backend_ecr
sed -i "s/terraform_state_bucket/$terraform_state_bucket/g" backend.tf
sed -i "s/aws-region/${aws_region}/g" variable.tf
sed -i "s/ecr-repo/${ecr_app}/g" variable.tf
sed -i "s/aws-region/${aws_region}/g" ecr_check.sh
sed -i "s/ecr-repo/${ecr_app}/g" ecr_check.sh
cat ecr_check.sh
chmod +x ecr_check.sh
./ecr_check.sh

