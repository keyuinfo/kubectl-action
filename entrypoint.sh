#!/bin/sh

set -e

mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config

# 根据参数Version修改发布文件
sed -i "s/v1.0/$INPUT_VERSION/g" $*

pods=$(kubectl get jobs --selector=job-name=$INPUT_JOBNAME --output=jsonpath='{.items[*].metadata.name}')
if [ ! -z "$pods" ]
then
	sh -c "kubectl delete job $pods && kubectl apply -f $*"
else
	sh -c "kubectl apply -f $*"
fi

