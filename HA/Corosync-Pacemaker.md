# Corosync & Pacemaker:

Corosync: Düğümler arasında iletişimi sağlar.
Pacemaker: Kaynakların durumunu izler ve gerektiğinde failover işlemini gerçekleştirir.

## Install:
```sh
sudo apt install corosync pacemaker pcs -y
```

## Services:
```sh
sudo systemctl enable pcsd
sudo systemctl start pcsd
```

# Create User:
```sh
sudo passwd hacluster
```

# Create Cluster:
```sh
pcs cluster setup --name ha_cluster node1 node
pcs cluster start --all
pcs cluster enable --all
```
