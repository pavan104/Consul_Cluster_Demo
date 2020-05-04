#!/bin/bash

usage() {
    echo ""
    echo "${0} <node_name> <encrypt> <private ip master 1> <private ip master 2> <private ip master 3> <private ip master 4> <private ip master 5>"
    echo ""
    echo "Arguments"
    echo "Node Name    - [REQUIRED] The node name you want to provide for your consul"
    echo "Encrypt      - [REQUIRED] This is acquired by running consul keygen."
    echo "Private IP master 1 - [REQUIRED] The private IP address of the master server 1."
    echo "Private IP master 2 - [REQUIRED] The private IP address of the master server 2."
    echo "Private IP master 3 - [REQUIRED] The private IP address of the master server 3."
    echo "Private IP master 4 - [REQUIRED] The private IP address of the master server 4."
    echo "Private IP master 5 - [REQUIRED] The private IP address of the master server 5."
    echo ""

    return
}

# Check to make sure the correct number of arguments is passed.
if [ "$#" -ne 7 ]; 
then
    usage
    exit
fi

NODENAME=$1
ENCRYPT_KEY=$2
PRIVATE_IP1=$3
PRIVATE_IP2=$4
PRIVATE_IP3=$5
PRIVATE_IP4=$6
PRIVATE_IP5=$7
SERVER_NAME=`hostname`
PRIVATE_IP=`ping $SERVER_NAME | head -1 | cut -d "(" -f 2 | cut -d ")" -f 1`

sed -i -- "s/__ENCRYPT__/$ENCRYPT_KEY/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__PRIVATE_IP__/$PRIVATE_IP/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__MASTER_NODE_NAME__/$NODENAME/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__PRIVATE_IP_1__/$PRIVATE_IP1/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__PRIVATE_IP_2__/$PRIVATE_IP2/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__PRIVATE_IP_3__/$PRIVATE_IP3/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__PRIVATE_IP_4__/$PRIVATE_IP4/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__PRIVATE_IP_5__/$PRIVATE_IP5/g" /home/ec2-user/Consul_Cluster_Demo/server.json

sed -i -- "s/__ENCRYPT__/$ENCRYPT_KEY/g" /home/ec2-user/Consul_Cluster_Demo/client.json
sed -i -- "s/__PRIVATE_IP__/$PRIVATE_IP/g" /home/ec2-user/Consul_Cluster_Demo/client.json
sed -i -- "s/__CLIENT_NODE_NAME__/$NODENAME/g" /home/ec2-user/Consul_Cluster_Demo/client.json
sed -i -- "s/__PRIVATE_IP_1__/$PRIVATE_IP1/g" /home/ec2-user/Consul_Cluster_Demo/client.json
sed -i -- "s/__PRIVATE_IP_2__/$PRIVATE_IP2/g" /home/ec2-user/Consul_Cluster_Demo/client.json
sed -i -- "s/__PRIVATE_IP_3__/$PRIVATE_IP3/g" /home/ec2-user/Consul_Cluster_Demo/client.json
sed -i -- "s/__PRIVATE_IP_4__/$PRIVATE_IP4/g" /home/ec2-user/Consul_Cluster_Demo/client.json
sed -i -- "s/__PRIVATE_IP_5__/$PRIVATE_IP5/g" /home/ec2-user/Consul_Cluster_Demo/client.json
