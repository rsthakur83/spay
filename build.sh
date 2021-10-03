export AWS_ACCOUNT_ID="$(aws sts get-caller-identity --query Account --output text)"
echo $AWS_ACCOUNT_ID
cd build
repo=$ecr_app
docker build -t $AWS_ACCOUNT_ID.dkr.ecr.$aws_region.amazonaws.com/$repo:$tag_name  .
