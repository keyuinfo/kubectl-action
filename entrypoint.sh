#!/bin/sh

set -e

mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config

# 根据参数Version修改发布文件
sed -i "s/v1.0/$INPUT_VERSION/g" $*

sh -c "kubectl apply -f $*"
