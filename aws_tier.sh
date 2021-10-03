#!/bin/bash
account_id=`aws sts get-caller-identity --query Account --output text`
cd ecsrole
chmod +x role-check.sh;./role-check.sh
cd ../app
sed -i  "s/ecr-repo/${ecr_app}/g"   deploy.sh
sed -i  "s|aws-region|$aws_region|g" deploy.sh
sed -i  "s|aws-region|$aws_region|g" ../task_definition.tf
sed -i  "s|ecr-repo|$ecr_app|g"      ../task_definition.tf
sed -i  "s|account-id|$account_id|g" ../task_definition.tf
sed -i  "s|tagnum|$tag_name|g"     ../task_definition.tf
sed -i  "s/terraform_state_bucket/$terraform_state_bucket/g" ../terraform_backend.tf
sed -i  "s|aws-region|$aws_region|g" ../terraform_backend.tf
cluster_name=`grep -A 1 "ECS cluster name" ../variable.tf |grep default|cut -d'"' -f 2`
sed -i  "s|clustername|$cluster_name|g" ../launch_configuration.tf
chmod +x deploy.sh
sed -i  's/\r$//' deploy.sh
./deploy.sh
