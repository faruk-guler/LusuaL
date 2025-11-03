# Corosync & Pacemaker:

Corosync: Düğümler arasında iletişimi sağlar.
Pacemaker: Kaynakların durumunu izler ve gerektiğinde failover işlemini gerçekleştirir.

## Install:
sudo apt install corosync pacemaker pcs -y

## Services:
sudo systemctl enable pcsd
sudo systemctl start pcsd

# Create User:
sudo passwd hacluster

# Create Cluster:
pcs cluster setup --name ha_cluster node1 node
pcs cluster start --all
pcs cluster enable --all
