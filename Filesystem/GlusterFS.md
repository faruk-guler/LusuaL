# GlusterFS CheatSheet 


### Print GlusterFS Status

        # gluster peer status

### List GlusterFS Volumes.

        # gluster volume list

### Print all GlusterFS Volumes

        # gluster volume info all

### Print GlusterFS Volumes status

        # gluster volume status


### Check Free Space per Node

        # gluster volume status \<volume\> detail
          
        Example:
        
        # gluster volume status vol_ac647934a1946304e0fd04223280adf3  detail

### Refrence URL for Heketi
        https://www.systutorials.com/docs/linux/man/8-heketi-cli/
       
### Lists the clusters managed by Heketi
        
        sh-4.2# heketi-cli cluster list
        Clusters:
        Id:2e2412d170c44a774e932a0f1ef5c063 [file][block]
        
### Retrieves the information about the cluster:
        
        sh-4.2# heketi-cli cluster info 2e2412d170c44a774e932a0f1ef5c063
        Cluster id: 2e2412d170c44a774e932a0f1ef5c063
        Nodes:
        041b1dd1ab2268dd26719aeb98f51c5c
        2598c4bc738581318969fdbeac85b21d
        5f56847753a64d8bd36274737f0c89ea
        b9c32f87d71c0bd955f9892cc04ac692
        Volumes:
        0013000aced51cf6e38b2f2f56dbcd14
        235a9eb0dc1a527eb0ac7a65d67ae1ec
        499ab82e4900510f85756ff7a744723c
        554c63b03c506691bfbf1775df59122b
        66cb0bd304f22dd3bac9116de9e795b1
        9a9e7484c982f88c686af2b420ebc3b0
        cffc3c0006b68301ba25633fe2394224
        e32ba947e04fce4400bb7ac4dd00e9aa
        e97e0d7987e7d90f82ca14639b0c82bc
        Block: true

        File: true
        sh-4.2#
        
### Retrieves the information abouth the node.
        
        sh-4.2# heketi-cli node info 041b1dd1ab2268dd26719aeb98f51c5c
        Node Id: 041b1dd1ab2268dd26719aeb98f51c5c
        State: online
        Cluster Id: 2e2412d170c44a774e932a0f1ef5c063
        Zone: 1
        Management Hostname: gluster01.example.com
        Storage Hostname: 10.197.164.30
        Devices:
        Id:dfe8cd66b537a9ac3dd5dd381630ad22   Name:/dev/sdd            State:online    Size (GiB):880     Used (GiB):58      Free (GiB):822     Bricks:5
        sh-4.2#
        
### List cluster nodes managed by Heketi.
        sh-4.2# heketi-cli node list
        Id:041b1dd1ab2268dd26719aeb98f51c5c     Cluster:2e2412d170c44a774e932a0f1ef5c063
        Id:2598c4bc738581318969fdbeac85b21d     Cluster:2e2412d170c44a774e932a0f1ef5c063
        Id:5f56847753a64d8bd36274737f0c89ea     Cluster:2e2412d170c44a774e932a0f1ef5c063
        Id:b9c32f87d71c0bd955f9892cc04ac692     Cluster:2e2412d170c44a774e932a0f1ef5c063
        sh-4.2#
        
### Lists the volumes managed by Heketi
      sh-4.2# heketi-cli volume list
        Id:0013000aced51cf6e38b2f2f56dbcd14    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:vol_0013000aced51cf6e38b2f2f56dbcd14
        Id:235a9eb0dc1a527eb0ac7a65d67ae1ec    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:vol_235a9eb0dc1a527eb0ac7a65d67ae1ec
        Id:499ab82e4900510f85756ff7a744723c    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:vol_499ab82e4900510f85756ff7a744723c
        Id:554c63b03c506691bfbf1775df59122b    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:vol_554c63b03c506691bfbf1775df59122b
        Id:66cb0bd304f22dd3bac9116de9e795b1    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:vol_66cb0bd304f22dd3bac9116de9e795b1
        Id:9a9e7484c982f88c686af2b420ebc3b0    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:vol_9a9e7484c982f88c686af2b420ebc3b0
        Id:cffc3c0006b68301ba25633fe2394224    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:heketidbstorage
        Id:e32ba947e04fce4400bb7ac4dd00e9aa    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:glusterfs-registry-volume
        Id:e97e0d7987e7d90f82ca14639b0c82bc    Cluster:2e2412d170c44a774e932a0f1ef5c063    Name:vol_e97e0d7987e7d90f82ca14639b0c82bc
        sh-4.2#
  
### Setup Environment Variable to access Heketi without loging to Heketi Server

        $ export HEKETI_CLI_SERVER=http://localhost:8080
        $ heketi-cli volume list
        
