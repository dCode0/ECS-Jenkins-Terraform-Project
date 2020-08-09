#!/bin/bash
sudo apt-get update
mkdir jenkins_data
docker run -d --name jenkins_server \
  -p ${port}:8080 -p 50000:50000 \
  --env JENKINS_PASSWORD=${username} \
  --env JENKINS_USERNAME=${password} \
  --volume jenkins_data:/bitnami/jenkins \
  bitnami/jenkins:latest