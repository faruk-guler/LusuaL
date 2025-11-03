# Corosync & Pacemaker:
Corosync ve Pacemaker, Linux tabanlı sistemlerde yüksek erişilebilirlik (High Availability - HA) sağlamak için birlikte kullanılan iki temel bileşendir.
Birlikte çalışarak sistemdeki servislerin veya uygulamaların otomatik olarak izlenmesini, yeniden başlatılmasını ve başka node’a taşınmasını (failover) sağlarlar.

- Corosync: Düğümler arasında iletişimi sağlar.
- Pacemaker: Kaynakların durumunu izler ve gerektiğinde failover işlemini gerçekleştirir.
- Pcs: Pacemaker ve Corosync kümelerini kolayca kurmak, yapılandırmak ve yönetmek için kullanılan bir yönetim aracı. (CLI + Web UI).
- Birlikte Çalışma: Corosync kümeyi "yapar", Pacemaker ise bu küme üzerinde servisleri yönetir. Standart bir HA kümesi için ikisi zorunludur.

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
pcs host auth Node1 Node2 -u hacluster -p <yourpasss>
pcs cluster setup --name ha_cluster node1 node
pcs cluster start --all
pcs cluster enable --all
```

## Status:
```sh
pcs status
pcs resource status
```

# Firewall:
```sh
firewall-cmd --permanent --add-service=high-availability
firewall-cmd –reload
```





