#!/bin/sh

ECR_REPO=mj/webapi
ECR_TAG=init
AWS_ACCOUNT=`aws sts get-caller-identity --query 'Account' --output text`
REGION=${AWS_DEFAULT_REGION:-${AWS_REGION:-"ap-northeast-1"}}

# build
docker build -t nginx:stable .

# login
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com

# tag and push
docker tag nginx:stable $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_REPO:$ECR_TAG
docker push $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_REPO:$ECR_TAG
