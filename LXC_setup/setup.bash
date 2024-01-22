#!/bin/bash

#Update System
yum update kernel -y
yum update -y && yum upgrade -y

#System utils
dnf install openssh-server nano sudo yum-utils wget curl zip iputils bind-utils traceroute firewalld iproute -y

#Docker install
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl enable docker
systemctl start docker

#Firewall
systemctl enable firewalld
systemctl start firewalld

firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --zone=public --permanent --add-service=ssh
firewall-cmd --reload

#Cleanup
dnf autoremove -y