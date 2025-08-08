
# 💾⚙️ Standard Partitions Management -farukguler.com

Eğer sistemde LVM (Logical Volume Manager) yapılandırılmamışsa, Linux dağıtımları varsayılan olarak standart bölümleri (standard partitions) kullanır.

Standart bölümler, belirli boyuttaki fiziksel disk alanlarını ayırmak ve her birini ayrı bir dosya sistemiyle formatlamak için kullanılır.
Bu bölümler, sistem dosyalarını veya kullanıcı verilerini içeren dizinler olabilir (örneğin /boot, /home, /var /logs /data vb.)

Linux’ta disk bölümleri çeşitli araçlarla oluşturulur, düzenlenir ve yönetilir. (parted, fdisk, gparted, .etc)

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
-----------------------------------|
# Tools: Fdisk
# Author: faruk-guler
# Size: < 2TB
# Format: ext3/ext4, xfs
-----------------------------------|
# Fdisk'i yükleyin:
sudo apt install util-linux -y
sudo dnf install util-linux -y
fdisk -v

# Disk/Dizin Durumu:
sudo du -hla /storage/log
sudo du -hla --max-depth=1 / | sort -h

# Disk Durumunu Kontrol Edin:
lsblk -o NAME,TYPE,SIZE,MODEL
ls -l /dev/sd* /dev/nvme* [SATA/SCSI, NVMe]
df -Th
lsblk -p
sudo fdisk -l

# Sisteme eklenen diski algıla: (SCSI, NVMe, .etc)
ls  /sys/class/scsi_host/
echo "- - -" | tee /sys/class/scsi_host/host*/scan
echo "1" > /sys/class/block/*/device/rescan

# Disk Bölümlendirme -Diski seçin:
sudo fdisk /dev/nvme0n2
sudo fdisk /dev/sdb

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
   e   extended (container for logical partitionsSelect (default p):[128 pieces]

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

# Disk değişikliklerini kernele tanıtın:
partprobe -s

# Disk/Bölüm Durumu:
sudo file -sL /dev/nvme0n2
sudo file -sL /dev/nvme0n2p1
sudo blkid /dev/repo_vg/logs [for LVM]

1- Disk/Bölüm Formatla: [Ext3/Ext4]: (sdb1,nvme0n2p1, ..)
#sudo mkfs -t ext4 /dev/nvme0n2 [Disk]
#sudo mkfs -t ext4 /dev/nvme0n2p1 [Bölüm]

2- Disk/Bölüm Formatla: [xfs]: (sdb1,nvme0n2p1, ...)
#sudo mkfs -t xfs /dev/nvme0n2
#sudo mkfs -t xfs /dev/nvme0n2p1

# Dizin İşlemleri:
sudo mkdir /storex
sudo mkdir -p /storex/hodl-77/xxx

# Mount & Umount:
sudo mount /dev/nvme0n2p1 /storex
sudo umount /storex
sudo umount -l /dev/nvme0n2p1

# UUID al:
sudo blkid -s UUID -o value /dev/nvme0n2p1

# fstab düzenleme: (Kalıcılık için)
sudo cp /etc/fstab /etc/fstab.old
nano /etc/fstab
>>
# UUID=7e1a91c5-23f4-4d58-8b1a-cc1e12345678 /storex ext4 defaults 0 0 [recommended]
# /dev/nvme0n2p1 /storex ext4 defaults 0 0
>>
sudo mount -av
sudo findmnt --verify
sudo systemctl daemon-reload

------------------------------------------------------------|
# Name: Genişlet ve Azalt (Online/Offline)
# Author: faruk-guler
# Note: Filesystem küçültüldükten sonra bölüm küçültülebilir. (genişletmenin tersi işlemi)
# 
-------------------------------------------------------------|

## >>> Extend İşlemi <<<

# fsck ile hataları kontrol edin:
sudo e2fsck -f -v /dev/nvme0n2p1
sudo e2fsck -f /dev/nvme0n2p1

# A1 -Boyut Öncesi Bölümü Genişletin:
Fdisk, Parted or Cfdisk Tool:
df -Th

# A2 - Dosya Sistemini Genişletin:
⦁⦁Ext3/Ext4 kullanıyorsanız: (resize2fs) [Online]
# sudo resize2fs /dev/nvme0n2p1 [%100]
# sudo resize2fs /dev/nvme0n2p1 18G [specific]
df -Th

⦁⦁Xfs kullanıyorsanız: (xfs_growfs) [Online]
# sudo xfs_growfs -d /dev/nvme0n2p1 [%100]
# sudo xfs_growfs /dev/nvme0n2p1 18G [specific]
df -Th

## >>> Reduce İşlemi <<< (only Ext3/Ext4) [önce filesystem küçültülür, sonra partition küçültülür]

# Disk verilerinden fazlasını küçültürseniz, veri kaybedersiniz!
# fsck ile hataları kontrol edin:
sudo e2fsck -f -v /dev/nvme0n2p1
sudo e2fsck -f /dev/nvme0n2p1

# İlk önce Dosya Sistemini boyutlandırın: (Ters İşlem)
⦁⦁Ext3/Ext4 kullanıyorsanız: (resize2fs) [Offline]
sudo umount /storex [umount]
sudo e2fsck -f /dev/nvme0n2p1
# sudo resize2fs /dev/nvme0n2p1 17G [specific size]

# Mount edin:
sudo mount /dev/nvme0n2p1 /storex [try mount]
df -Th

```
```sh
-------------------------|
# Tools: Parted
# Author: faruk-guler
# Size: > 2TB
-------------------------|

# Parted'ı kurun:
sudo apt install parted
sudo yum install parted
parted --version

# 

```

[Standard Partitions - Install, Configure, Manage -farukguler.com](https://farukguler.com/posts/standard-partitions-install-configure-manage/)
