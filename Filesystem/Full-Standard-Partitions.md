
# 💾⚙️ Standard Partitions Management -farukguler.com

Eğer sistemde LVM (Logical Volume Manager) yapılandırılmamışsa, Linux dağıtımları varsayılan olarak standart bölümleri (standard partitions) kullanır.

Standart bölümler, belirli boyuttaki fiziksel disk alanlarını ayırmak ve her birini ayrı bir dosya sistemiyle biçimlendirmek için kullanılır.
Bu bölümler, sistem dosyalarını veya kullanıcı verilerini içeren dizinler olabilir (örneğin /boot, /home, /var /logs /data vb.)

Linux’ta disk bölümleri çeşitli araçlarla oluşturulur, düzenlenir ve yönetilir. (parted, fdisk, gparted, ...)

<p align="left">
  <img src="https://farukguler.com/assets/post_images/disk-lnx.jpg" alt="LVM Logo" width="500"/>
</p>


# Standard Partitions: [Install, Configure, Manage:]

```sh
# Name: İleriye dönük optimize disk bölümleme planı
# Yapı: Tüm veri alanları standart partitions ile yönetilir.
# Disk Space: 4TB
# Swap: swap alanı gerekirse, /data altında "swapfile" oluşturulabilir.
# ESP: UEFI sistem kullanılıyorsa EFI System Partition (ESP) alanı zorunludur.

  /dev/sda1     /dev/sda2       /dev/sda3     /dev/sda4      <--- Genişletilebilir --->
-------------+-------------+---------------+----------------+----------------------------+
/boot/efi    |  /boot      |      /        |   /data        |         boş alan           |
-------------+-------------+---------------+----------------+----------------------------+
  500MB–1GB      500MB          75-100GB       500-800GB+
  FAT32           ext4      ext4/xfs/btrsf    ----------
```

```sh
--------------------------------|
# Tools: Fdisk
# Author: faruk-guler
# 
--------------------------------|
# Install Fdisk:
sudo apt install util-linux -y
sudo yum install util-linux -y
fdisk -v

# Disk/Directory Status:
sudo du -hla /storage/log
sudo du -hla --max-depth=1 / | sort -h

# Check Disk Status:
ls -l /dev/sd*
df -Th
lsblk -p
sudo fdisk -l

# Check the disk added to the system: (SCSI or NVMe)
ls  /sys/class/scsi_host/
echo "- - -" | tee /sys/class/scsi_host/host*/scan
echo "1" > /sys/class/block/sda/device/rescan

# Disk Partitioning 
sudo fdisk /dev/nvme0n2
sudo fdisk /dev/sdb1

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

# Write the changes to disk. [Attention!]
t - Change partition type:
L - List partition type:
8e - Set/change partition type:
#w - Write changes to disk:
p - List disk partitions:
q - Exit from fdisk tool:

# Introduce disk changes to the Kernel:
partprobe -s

# Disk/Partition Status:
sudo file -sL /dev/nvme0n2
sudo blkid /dev/repo_vg/logs

1- Disk, Partition Formatting [Ext3/Ext4]: (sdb1,nvme0n2p1, ..)
#sudo mkfs -t ext4 /dev/nvme0n2
#sudo mkfs -t ext4 /dev/nvme0n2p1

2- Disk, Partition Formatting [Xfs]: (sdb1,nvme0n2p1, ...)
#sudo mkfs -t xfs /dev/nvme0n2
#sudo mkfs -t xfs /dev/nvme0n2p1

# Directory Ops.:
sudo mkdir /alan
sudo mkdir -p /alan/hodl-77/xxx (sub tree)

# Mount & Umount:
sudo mount /dev/nvme0n2p1 /alan
sudo umount /dev/nvme0n2p1 /alan
sudo umount -l /dev/nvme0n2p1 /alan

# fstab edit: (for Persistence)
sudo cp /etc/fstab /etc/fstab.old
cat /etc/fstab
# nano /etc/fstab
# /dev/nvme0n2p1 /alan ext4 defaults 0 0
sudo mount -av
sudo findmnt --verify
sudo systemctl daemon-reload

-------------------------------------------------------------|
# Name: Extend and Reduce  **Online/Offline
# Author: faruk-guler
# 
-------------------------------------------------------------|

## >>> Extend Operation <<<

# Check for errors with fsck:
sudo e2fsck -ff -v /dev/nvme0n2p1
sudo e2fsck -f /dev/nvme0n2p1

# A1 -Before size Extend the Partition:
df -Th

# A2 -After size Extend the File System:
⦁⦁If you are using Ext3/Ext4: (resize2fs) [Online]
# sudo resize2fs /dev/nvme0n2p1 [%100]
# sudo resize2fs /dev/nvme0n2p1 18G [spesific]
df -Th

⦁⦁If you are using Xfs: (xfs_growfs) [Online]
# sudo xfs_growfs -d /dev/nvme0n2p1 [%100]
# sudo xfs_growfs /dev/nvme0n2p1 18G [spesific]
df -Th

## >>> Reducing Operation <<< (only Ext3/Ext4)

# If you shrink more than the disk data, you will lose data!
# Check for errors with fsck:
sudo e2fsck -ff -v /dev/nvme0n2p1
sudo e2fsck -f /dev/nvme0n2p1

# First size the File System: (Reverse Operation)
⦁⦁If you are using Ext3/Ext4: (resize2fs) [Offline]
sudo umount /dev/nvme0n2p1 /alan [umount]
sudo e2fsck -f /dev/nvme0n2p1
# sudo resize2fs /dev/nvme0n2p1 17G [spesific size]
sudo mount /dev/nvme0n2p1 /alan [try mount]
df -Th

```
```sh
-------------------------|
# Tools: Parted
# Author: faruk-guler
# 
-------------------------|

# Install Parted:
sudo apt install parted
sudo yum install parted
parted --version

# 

```

[Standard Partitions - Install, Configure, Manage -farukguler.com](https://farukguler.com/posts/standard-partitions-install-configure-manage/)
