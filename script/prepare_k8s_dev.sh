#!/bin/bash

#
# create a kind kubernetes environment based on a fresh Ubuntu Linux node
#

# install go lang
echo "installing go lang..."
curl -LO https://golang.org/dl/go1.17.linux-amd64.tar.gz
tar -zxvf go1.17.linux-amd64.tar.gz 
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile
rm go1.17.linux-amd64.tar.gz

export PATH=$PATH:/usr/local/go/bin
go version


# install kubectl
echo "installing kubectl ..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl 

kubectl version --client


# install docker
echo "installing docker..."
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

docker run hello-world

# install kind
echo "installing kind..."
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
chmod u+x ./kind
mv ./kind /usr/local/bin/kind

# create a kubernetes cluster
echo "creating a kind kubernetes cluster..."
kind create cluster --name ant

kubectl get node

