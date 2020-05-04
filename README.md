# Consul_Cluster_Demo
Consul Cluster Build Demo

<pre><code>#Cluster Structure
--------------------------------
Consul Master/Bootstrap Server : Build 5 aws ec2 instances and tag them with "Consul-Master-1"
Consul Client/Agent Server : Build 5 aws ec2 instances and tag them with "Consul-Client-1"
</code></pre>

<pre><code>#Run these on all consul servers
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

<pre><code># Consul Encryption key and Basic setup
---------------------------
ENCRYPT_KEY=`consul keygen`
cd /home/ec2-user/Consul_Cluster_Demo/
./setup.sh <node_name> <encrypt> <private ip master 1> <private ip master 2> <private ip master 3> <private ip master 4> <private ip master 5>

For eg.
Run on each Master Server by changing node_name :
./setup.sh Consul-Master-1 $ENCRYPT_KEY 172.31.21.159 172.31.4.234 172.31.5.212 172.31.28.209 172.31.24.179

Run on each Client Server by changing node_name :
./setup.sh Consul-Client-1 $ENCRYPT_KEY 172.31.21.159 172.31.4.234 172.31.5.212 172.31.28.209 172.31.24.179
</code></pre>

<pre><code># Consul Master/Bootstrap Server
--------------------------------
mkdir -m 755 /consul/config
mkdir -m 755 /consul/data
mkdir -m 755 /consul/logs
cd /consul/config
cp /home/ec2-user/Consul_Cluster_Demo/server.json config.json
consul agent -config-dir /consul/config/config.json >> /consul/logs/consul_master.log &
</code></pre>

<pre></code>#Consul Client/Agent Server
--------------------------------
mkdir -m 755 /consul/config
mkdir -m 755 /consul/data
mkdir -m 755 /consul/logs
cd /consul/config
cp /home/ec2-user/Consul_Cluster_Demo/client.json config.json
consul agent -config-dir /consul/config/config.json >> /consul/logs/consul_client.log &
</code></pre>
