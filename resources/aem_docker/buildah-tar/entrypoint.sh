#!/bin/bash

cd /root
pwd
ls -lrt
git clone git@github.com:vjkri/docker-in-docker.git

/root/google-cloud-sdk/bin/gcloud auth activate-service-account --key-file=/root/key.json
export GOOGLE_APPLICATION_CREDENTIALS=/root/key.json
/root/google-cloud-sdk/bin/gcloud auth configure-docker --quiet
cp -r /root/google-cloud-sdk/lib/* /usr/local/lib/
PATH=$PATH:/root/google-cloud-sdk/bin
cd docker-in-docker/resources/aem_docker/dispatcher-ps/
buildah --storage-opt overlay.mountopt=nodev bud -t eu.gcr.io/newdemo-246311/nginx .
buildah --storage-opt overlay.mountopt=nodev images
buildah --storage-opt overlay.mountopt=nodev push eu.gcr.io/newdemo-246311/nginx
