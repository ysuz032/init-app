#!/bin/sh

if [ $# -lt 2 ] || [ $# -gt 2 ]; then
    echo "使用方法: $0 <repository-name> <image-tag>"
    echo "例: $0 sample/repo latest"
    exit 1
fi

ECR_REPO="$0"
ECR_TAG="$1"
AWS_ACCOUNT=`aws sts get-caller-identity --query 'Account' --output text`
REGION=${AWS_DEFAULT_REGION:-${AWS_REGION:-"ap-northeast-1"}}

# build
docker build -t nginx:stable .

# login
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com

# tag and push
docker tag nginx:stable $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_REPO:$ECR_TAG
docker push $AWS_ACCOUNT.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_REPO:$ECR_TAG
