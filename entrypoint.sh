#!/bin/sh

set -e

mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config

set +e
# 删除所有成功的Jobs
sh -c "kubectl delete job $(kubectl get job -o=jsonpath='{.items[?(@.status.succeeded==1)].metadata.name}')"
set -e

# 根据参数Version修改发布文件
sed -i "s/v1.0/$INPUT_VERSION/g" $*

sh -c "kubectl apply -f $*"
