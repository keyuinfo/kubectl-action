#!/bin/sh

set -e

mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config

# 根据参数Version修改发布文件
sed -i "s/v1.0/$INPUT_VERSION/g" $*

set +e
echo "kubectl delete job -n $INPUT_NAMESPACE $INPUT_JOBNAME"
sh -c "kubectl delete job -n $INPUT_NAMESPACE $INPUT_JOBNAME"
set -e

echo 'hello workflow'
# echo "kubectl apply -n $INPUT_NAMESPACE -f $*"
# sh -c "kubectl apply -n $INPUT_NAMESPACE -f $*"
