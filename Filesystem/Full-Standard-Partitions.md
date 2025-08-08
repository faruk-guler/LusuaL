
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
# Size: < 2TB MBR (DOS) / > 2 TB GPT
# Format: ext4, xfs
-----------------------------------|

# Fdisk'i yükleyin:
sudo apt install util-linux -y # Debian
sudo dnf install util-linux -y # RedHat
fdisk --version

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
echo "1" > /sys/class/block/*/device/rescan
echo "- - -" | sudo tee /sys/class/scsi_host/host*/scan
echo "1" | sudo tee /sys/class/block/*/device/rescan

# Disk Bölümlendirme -Diski seçin:
sudo fdisk /dev/nvme0n2
sudo fdisk /dev/sda

Welcome to fdisk (util-linux 2.38.1).
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
   p   primary (0 primary, 0 extended, 4 free) [Max 4 partitions]
   e   extended (container for logical partitions Select (default p):[128 partitions]

*Specify the starting and ending sectors. You can use 100% of all unallocated space.
*Disk type will be [Linux] by default.
*To change this, use the [t] command.
*Specify the partition type and number we want to change.

# Write the changes to disk. [Attention!]
t - Change partition type:
L - List partition type:
83 - Set/change partition type:
#w - Write changes to disk:
p - List disk partitions:
q - Exit from fdisk tool:

# Disk değişikliklerini kernele tanıtın:
partprobe -s

# Disk/Bölüm/Dizin Durumu:
sudo file -sL /dev/nvme0n2
sudo file -sL /dev/nvme0n2p1
sudo tune2fs -l /dev/nvme0n2p1
sudo blkid /dev/repo_vg/logs [for LVM]

1- Disk/Bölüm Formatla: [Ext4]: (sdb1,nvme0n2p1, ..)
#sudo mkfs -t ext4 /dev/nvme0n2 [Disk]
#sudo mkfs -t ext4 /dev/nvme0n2p1 [Bölüm]

2- Disk/Bölüm Formatla: [xfs]: (sdb1,nvme0n2p1, ...)
#sudo mkfs -t xfs /dev/nvme0n2 [Disk]
#sudo mkfs -t xfs /dev/nvme0n2p1 [Bölüm]

# Dizin İşlemleri:
sudo mkdir /storex
sudo mkdir -p /storex/hodl-77/xxx

# Mount & Umount:
sudo mount -t ext4 /dev/nvme0n2p1 /storex [ext4]
sudo mount -t xfs /dev/nvme0n2p1 /storex [xfs]
sudo mount -t ntfs-3g /dev/nvme0n2p1 /storex [for NTFS]
sudo lsof /storex 
sudo umount /storex
sudo umount -l /dev/nvme0n2p1

# UUID al:
sudo blkid /dev/nvme0n2 [Disk]
sudo blkid /dev/nvme0n2p1 [Bölüm]

# fstab düzenleme: (Kalıcılık için)
sudo cp /etc/fstab /etc/fstab.old
sudo nano /etc/fstab
>>
# UUID=7e1a91c5-23f4-4d58-8b1a-cc1e12345678 /storex ext4 defaults 0 0 [PARTUUID önerilir]
# /dev/nvme0n2p1 /storex ext4 defaults 0 0
>>
sudo mount -av
sudo findmnt --verify

-----------------------------------------------------------------|
# Name: Genişlet ve Azalt (Online/Offline)
# Author: faruk-guler
# Note: Filesystem küçültüldükten sonra partition küçültülebilir.
# 
-----------------------------------------------------------------|

## >>> Extend İşlemi <<<

# Hataları kontrol edin: [xfs_repair/fsck]
sudo e2fsck -f -v /dev/nvme0n2p1
sudo xfs_repair /dev/nvme0n2p1

# A1 -Boyut Öncesi Bölümü Genişletin: (fdisk tool)
#sudo fdisk /dev/nvme0n2
> a. sil (d)
> b. yeni (daha büyük, aynı başlangıç) (n)
> c. değişikliği yaz (w)
sudo partprobe

# A2 - Dosya Sistemini Genişletin:
==Ext4 kullanıyorsanız: (resize2fs) [Online]
# sudo resize2fs /dev/nvme0n2p1 [%100]
# sudo resize2fs /dev/nvme0n2p1 18G [specific]
df -Th

==xfs kullanıyorsanız: (xfs_growfs) [Online]
# sudo xfs_growfs -d /storex
# sudo xfs_growfs -d /dev/nvme0n2p1 [%100]
# sudo xfs_growfs /dev/nvme0n2p1 18G [specific]
df -Th

## >>> Reduce İşlemi <<< (only Ext4)
## önce filesystem küçültülür, sonra partition küçültülür]
## Disk verilerinden fazlasını küçültürseniz, veri kaybedersiniz!
## XFS dosya sistemini küçültülmez! 2025

# Umount edin:
sudo umount /storex [umount]

# Hataları kontrol edin: [xfs_repair/fsck]
sudo e2fsck -f -v /dev/nvme0n2p1
sudo xfs_repair /dev/nvme0n2p1

# Minimum güvenli boyutu öğrenin:
sudo resize2fs -P /dev/nvme0n2p1

# Önce filesystemi küçültün: (Ters İşlem) [Offline]
# sudo resize2fs /dev/nvme0n2p1 17G [specific size]

# Partition tablosunu fdisk veya parted ile küçültün:
sudo fdisk /dev/nvme0n2
> a. Mevcut bölümü silin (d)
> b. Aynı başlangıç sektörüyle (aynı) yeni bir bölüm oluşturun (n)
> c. Yeni boyutu belirtin (örneğin, 17G)
> d. Değişiklikleri yazın (w) [Dikkat!]

# Kernele değişikliği tanıtın:
sudo partprobe -s

# Dosya sistemini kontrol et:
sudo e2fsck -f /dev/nvme0n2p1

# Tekrar Mount edin:
sudo mount /dev/nvme0n2p1 /storex
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
