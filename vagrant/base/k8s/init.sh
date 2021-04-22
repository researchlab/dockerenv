#!/bin/sh

# disable firewalld 
iptables -F
systemctl stop firewalld 
systemctl disable firewalld 

#disable selinux 
sudo sed -i 's+SELINUX=enforcing+SELINUX=disabled+' /etc/selinux/config
setenforce 0

# 开启内核模块
modprobe br_netfilter 

# k8s config 
cat>/etc/sysctl.d/k8s.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl -p /etc/sysctl.d/k8s.conf

# disable swap 
swapoff -a 

# install k8s components 
yum install -y yum-utils device-mapper-persisten-data lvm2 wget vim net-tools

wget -O /etc/yum.repos.d/docker-ce.repo https://download.docker.com/linux/centos/docker-ce.repo

sudo sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo

cat>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

sudo yum makecache fast 
yum install -y docker-ce kubelet-1.20.0 kubeadm-1.20.0 kubectl-1.20.0

systemctl start docker 
systemctl enable docker 

systemctl start kubelet 
systemctl enable kubelet
