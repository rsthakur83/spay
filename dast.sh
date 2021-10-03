docker run -d -p 5000:5000 --name app $AWS_ACCOUNT_ID.dkr.ecr.$aws_region.amazonaws.com/$repo:$tag_name 
docker run -t owasp/zap2docker-stable zap-baseline.py -t http://172.17.0.1:5000  || true
docker stop app &
docker rm app &
