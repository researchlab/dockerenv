#!/bin/bash 
# 1087  vpn port
localip=$(ifconfig |grep 'netmask' | grep 10.21.71 | cut -d' ' -f2)
minikube delete && minikube start --cpus=4 --memory=4096 --disk-size=10g \
	--docker-env http_proxy=${localip}:1087 \
	--docker-env https_proxy=${localip}:1087 \
	--docker-env no_proxy=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24 \
	--docker-env no_proxy=$no_proxy,$(minikube ip) \
	--registry-mirror=https://registry.docker-cn.com \
  --insecure-registry=192.168.39.0/24

