export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
#echo $AWS_ACCOUNT_ID
#cd build
repo=$ecr_app
cred=`aws ecr get-login --no-include-email --region $aws_region`
echo '#!/bin/sh' > /tmp/ecr_login.sh
echo $cred >> /tmp/ecr_login.sh
chmod +x /tmp/ecr_login.sh
/tmp/ecr_login.sh
trivy image $AWS_ACCOUNT_ID.dkr.ecr.$aws_region.amazonaws.com/$ecr_app:$tag_name
docker push $AWS_ACCOUNT_ID.dkr.ecr.$aws_region.amazonaws.com/$repo:$tag_name
