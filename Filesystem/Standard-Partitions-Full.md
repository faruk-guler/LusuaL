
# 💾⚙️ Standard Partitions Management -farukguler.com

Standard disk configuration in Linux usually includes standard partitions. This configuration divides the hard disk into physically separated partitions and formats each as a separate file system. "If Linux systems do not have LVM (Logical Volume Manager), standard partitions are used by default.

Standard partitions are used to separate physical disk spaces of a certain size and format each with a separate file system. These partitions may be directories containing system files or user data, such as (/boot, /home, /var /logs .etc.)

## Standart Disk Mimarisi:

<p align="left">
  <img src="https://farukguler.com/assets/post_images/disk-lnx.jpg" alt="LVM Logo" width="500"/>
</p>


👨🏼‍💻 Standard Partitions: [Manage]
##System: RHELL / Centos /Debian /Alma /Ubuntu
##Tools: Fdisk

```sh
--------------------------------------------|
#[Standard Partitions] Install, Configure:
--------------------------------------------|

#Disk/Directory Status:
sudo du -hla /storage/log
sudo du -hla --max-depth=1 / | sort -h

#Check Status:
ls -l /dev/sd*
df -Th
lsblk -p
sudo fdisk -l

#Check the disk added to the system: (SCSI or NVMe)
ls  /sys/class/scsi_host/
echo "- - -" | tee /sys/class/scsi_host/host*/scan
echo "1" > /sys/class/block/sda/device/rescan

##Disk Partitioning##
#Using Fdisk: [sdb1, nvme0n2, ...]
sudo fdisk /dev/nvme0n2

Welcome to fdisk (util-linux 2.37.4).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Command (m for help):
m - print this help menu:
n - add a new partition:
p - print the partition table:

Create a new label
   g - create a new empty GPT partition table [1-128 Partitions]
   G - create a new empty SGI (IRIX) partition table
   o - create a new empty DOS partition table
   s - create a new empty Sun partition table

Partition type
   p   primary (0 primary, 0 extended, 4 free) [Max 4 pieces]
   e   extended (container for logical partitionsSelect (default p):[Unlimited]

*Specify the starting and ending sectors. You can use 100% of all unallocated space.
*Disk type will be [Linux] by default.
*To change this, use the [t] command.
*Specify the partition type and number we want to change.
#Write the changes to disk. [Attention!]
t - Change partition type:
L - List partition type:
8e - Set/change partition type:
#w - Write changes to disk:
p - List disk partitions:
q - Exit from fdisk tool:

#Introduce disk changes to the kernel:
partprobe -s

Disk/Partition Status:
sudo file -sL /dev/nvme0n2
sudo blkid /dev/repo_vg/logs

1- Disk, Partition Formatting [Ext3/Ext4]: (sdb1,nvme0n2p1, ..)
#sudo mkfs -t ext4 /dev/nvme0n2
#sudo mkfs -t ext4 /dev/nvme0n2p1

2- Disk, Partition Formatting [Xfs]: (sdb1,nvme0n2p1, ...)
#sudo mkfs -t xfs /dev/nvme0n2
#sudo mkfs -t xfs /dev/nvme0n2p1

#Folder Ops.:
sudo mkdir /alan
sudo mkdir -p /alan/hodl-77/xxx (sub tree)

#Mount & Umount:
sudo mount /dev/nvme0n2p1 /alan
sudo umount /dev/nvme0n2p1 /alan
sudo umount -l /dev/nvme0n2p1 /alan

#fstab edit: (Persistence)
sudo cp /etc/fstab /etc/fstab.old
cat /etc/fstab
#nano /etc/fstab
#/dev/nvme0n2p1 /alan ext4 defaults 0 0
sudo mount -av
sudo findmnt --verify
sudo systemctl daemon-reload
```
```sh
-------------------------------------------------------------------|
#[Standard Partitions] Manage: Extend and Reduce  **Online/Offline
-------------------------------------------------------------------|

##>>A +Extend Operation##
#Check for errors with fsck:
sudo e2fsck -ff -v /dev/nvme0n2p1
sudo e2fsck -f /dev/nvme0n2p1

#A1 -First size Extend the Partition:
Fdisk tool:
Parted or Cdisk tool:
df -Th

#A2 -Later size Extend the File System:
⦁If you are using Ext3/Ext4: (resize2fs) [Online]
#sudo resize2fs /dev/nvme0n2p1 [%100]
#sudo resize2fs /dev/nvme0n2p1 18G [spesific]
df -Th

⦁If you are using Xfs: (xfs_growfs) [Online]
#sudo xfs_growfs -d /dev/nvme0n2p1 [%100]
#sudo xfs_growfs /dev/nvme0n2p1 18G [spesific]
df -Th

##>>B +Reducing Operation ## (only Ext3/Ext4, not Xfs)
#If you shrink more than the disk data, you will lose data!
#Check for errors with fsck:
sudo e2fsck -ff -v /dev/nvme0n2p1
sudo e2fsck -f /dev/nvme0n2p1

#B1 First size the File System: (Reverse)
⦁If you are using Ext3/Ext4: (resize2fs) [Offline]
sudo umount /dev/nvme0n2p1 /alan [umount]
sudo e2fsck -f /dev/nvme0n2p1
#sudo resize2fs /dev/nvme0n2p1 17G [spesific size]
sudo mount /dev/nvme0n2p1 /alan [try mount]
df -Th

```

[Standard Partitions - Install, Configure, Manage -farukguler.com](https://farukguler.com/posts/standard-partitions-install-configure-manage/)
