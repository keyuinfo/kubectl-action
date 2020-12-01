#!/bin/sh

set -e

mkdir -p ~/.kube
echo $INPUT_KUBECONFIG | base64 -d > ~/.kube/config

OUTDATED_JOBS=$(kubectl get job -o=jsonpath='{.items[?(@.status.succeeded==1)].metadata.name}')
if [ ! -z "$OUTDATED_JOBS" ]
then
	# 删除所有成功的Jobs
	sh -c "kubectl delete job $OUTDATED_JOBS"
fi

# 根据参数Version修改发布文件
sed -i "s/v1.0/$INPUT_VERSION/g" $*

sh -c "kubectl apply -f $*"
