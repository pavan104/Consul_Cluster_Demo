# Consul_Cluster_Demo
Consul Cluster Build Demo

<pre><code># Consul - Cluster Structure
--------------------------------
Consul Master/Bootstrap Server : Build 5 public aws ec2 instances and tag them with "Consul-Master-1"
Consul Client/Agent Server : Build 5 public aws ec2 instances and tag them with "Consul-Client-1"

Also make sure inbound and outbound rules is open for all traffic.
</code></pre>

<pre><code># Consul - Download, Install, Config 
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

<pre><code># Consul - Encryption key and Basic setup
--------------------------------
ENCRYPT_KEY=`consul keygen`
# Save this keygen! Note, if your key has a slash in it you need to escape them for setup.sh. Or just regenerate one until it doesn't have a slash :)
# Please use this key for each master and client setup, we dont need to create key for each client and master. This is one time task.
--------------------------------
cd /home/ec2-user/Consul_Cluster_Demo/
./setup.sh node_name encrypt_key private_ip_master_1 private_ip_master_2 private_ip_master_3 private_ip_master_4 private_ip_master_5

# For eg.
# Run on each Master Server by changing node_name :
./setup.sh Consul-Master-1 $ENCRYPT_KEY 172.31.21.159 172.31.4.234 172.31.5.212 172.31.28.209 172.31.24.179

# Run on each Client Server by changing node_name :
./setup.sh Consul-Client-1 $ENCRYPT_KEY 172.31.21.159 172.31.4.234 172.31.5.212 172.31.28.209 172.31.24.179
</code></pre>

<pre><code># Consul - Master/Bootstrap Server
--------------------------------
mkdir -m 755 /consul/config
mkdir -m 755 /consul/data
mkdir -m 755 /consul/logs
cd /consul/config
cp /home/ec2-user/Consul_Cluster_Demo/server.json config.json
consul agent -config-dir /consul/config/config.json >> /consul/logs/consul_master.log &
</code></pre>

<pre></code># Consul - Client/Agent Server
--------------------------------
mkdir -m 755 /consul/config
mkdir -m 755 /consul/data
mkdir -m 755 /consul/logs
cd /consul/config
cp /home/ec2-user/Consul_Cluster_Demo/client.json config.json
consul agent -config-dir /consul/config/config.json >> /consul/logs/consul_client.log &
</code></pre>

<pre><code># Consul - Quick Links
• Introduction to HashiCorp Consul - https://www.youtube.com/watch?v=mxeMdl0KvBI
• Consul Download - https://releases.hashicorp.com/consul/
• Consul Configuration Parameters - https://www.consul.io/docs/agent/options.html
</code></pre>
