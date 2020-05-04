# Consul_Cluster_Demo
Consul Cluster Build Demo

<pre><code>
#Run these on all consul servers
--------------------------------
sudo yum update
sudo yum install -y unzip
sudo yum install -y git
VERSION=1.7.2
cd /home/ec2-user
wget https://releases.hashicorp.com/consul/${VERSION}/consul_${VERSION}_linux_amd64.zip
unzip consul_${VERSION}_linux_amd64.zip
rm -rf *.zip
sudo mv consul /usr/local/bin/
git clone https://github.com/pavan104/Consul_Cluster_Demo.git
</code></pre>

<pre><code>
# Consul Encryption key
---------------------------
ENCRYPT_KEY=`consul keygen`
sed -i -- "s/__ENCRYPT__/$ENCRYPT_KEY/g" /home/ec2-user/Consul_Cluster_Demo/server.json
sed -i -- "s/__ENCRYPT__/$ENCRYPT_KEY/g" /home/ec2-user/Consul_Cluster_Demo/client.json
</code></pre>

<pre><code>
# Consul Master/Bootstrap Server
--------------------------------
mkdir -m 755 /consul/config
mkdir -m 755 /consul/data
mkdir -m 755 /consul/logs
cd /consul/config
cp /home/ec2-user/Consul_Cluster_Demo/server.json config.json
consul agent -config-dir /consul/config/config.json >> /consul/logs/consul_master.log &
</code></pre>

<pre></code>
#Consul Client/Agent Server
--------------------------------
mkdir -m 755 /consul/config
mkdir -m 755 /consul/data
mkdir -m 755 /consul/logs
cd /consul/config
cp /home/ec2-user/Consul_Cluster_Demo/client.json config.json
consul agent -config-dir /consul/config/config.json >> /consul/logs/consul_client.log &
</code></pre>
