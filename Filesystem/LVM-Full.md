
# LVM Logical Volume Management -farukguler.com

Mantıksal Birim Yöneticisi (LVM), Linux sistemlerinde depolama yönetiminde esneklik sağlayan bir disk soyutlama katmanıdır. LVM, fiziksel diskleri soyutlayarak mantıksal bir depolama havuzu oluşturur ve bu havuzdan esnek mantıksal diskler (mantıksal birimler) tahsis etmenize olanak tanır. Bu, depolama alanınızı daha esnek bir şekilde yönetmenize, genişletmenize veya daraltmanıza olanak tanır.

## LVM Mimarisi:
<p align="left">
  <img src="https://farukguler.com/assets/post_images/lvm-best.jpg" alt="Ansible Logo" width="500"/>
</p>

```sh
#Install:
sudo apt install lvm2         # Debian/Ubuntu
sudo yum install lvm2         # RHEL/CentOS
sudo zypper install lvm2      # SUSE/openSUSE:

#LVM Configuration:
/etc/lvm/lvm.conf

## General view:
sudo pvscan
sudo vgscan
sudo lvscan

## LV Yolları ve Alternatifler:
/dev/vg_name/lv_name           # Standart yol
/dev/mapper/vg_name-lv_name    # Device mapper yolu
/dev/dm-N                      # Düşük seviye device mapper aygıtı

## Fiziksel Disk Oluşturma (PV)
sudo pvcreate /dev/sdb            # Tek bir disk ekleme
sudo pvcreate /dev/sdb1           # Belirli bir bölümü ekleme
sudo pvcreate /dev/sdc /dev/sdd   # Birden fazla disk ekleme
sudo pvs                          # PV'leri listele
sudo pvdisplay                    # Detaylı bilgi göster

## Volume Group Oluşturma (VG)
sudo vgcreate vg_name /dev/sdb            # Tek bir PV ile VG oluşturma
sudo vgcreate vg_name /dev/sdb3	          # Belirli bölümden VG oluşturma
sudo vgcreate vg_name /dev/sdb /dev/sdc   # Birden fazla PV ile VG oluşturma
sudo vgcreate --physicalextentsize 8G vg_name /dev/sdb # Özel PE boyutu ile VG oluşturma (örn. 8GB)
sudo vgcreate vg_veri /dev/sdb /dev/sdc   # "vg_veri" adında VG oluştur
sudo vgs                                  # VG'leri listele
sudo vgdisplay                            # Detaylı bilgi göster

## Logical Volume Oluşturma (LV)
sudo lvcreate -L 20G -n lv_home vg_veri         # 20GB'lık "lv_home" LV'si oluştur
sudo lvcreate -l 80%VG -n lv_name vg_name       # VG'nin yüzdesini kullanarak LV oluştur
sudo lvcreate -l 100%FREE -n lv_backup vg_veri  # Tüm boş alanı kullan
sudo lvs                                        # LV'leri listele
sudo lvdisplay                                  # Detaylı bilgi göster

## Dosya Sistemi Oluşturma ve Mount Etme
sudo mkfs.ext4 /dev/vg_veri/lv_home           # EXT4 dosya sistemi oluştur
sudo mkfs.xfs /dev/vg_name/lv_name            # XFS dosya sistemi oluştur
sudo mkdir /mnt/home                          # Mount dizini oluştur
sudo mount /dev/vg_veri/lv_home /mnt/home     # Mount et

## Kalıcı Mount /etc/fstab:
sudo cp /etc/fstab /etc/fstab.old
#nano /etc/fstab
#/dev/vg_veri/lv_home /mnt/home ext4 defaults 0 0
#/dev/vg_veri/lv_home /mnt/home xfs defaults 0 0
#UUID=xxxx-xxxx /mnt/home ext4 defaults 0 0 (UUID ile güvenli önerilen)
sudo mount -av
sudo findmnt --verify

## LV Genişletme (Boyut Artırma )
################################
sudo lvextend -L 20G /dev/vg_name/lv_name        # LV'yi belirli bir boyuta ayarlama  (20GB) (artırma veya azaltma yapar. azaltılırsa veri kaybı riski!)
sudo lvextend -L +10G /dev/vg_veri/lv_home       # LV'ye belirli bir miktar alan ekleme (10GB)
sudo lvextend -l +100%FREE /dev/vg_name/lv_name  # LV VG'nin tüm boş alanını kullansın

## Dosya Sistemi Boyutlandırma (file system resizing extend/reduce)
#################################
sudo resize2fs /dev/vg_veri/lv_home          # EXT4 dosya sistemini boyutlandır
sudo xfs_growfs /mnt/home                    # XFS  dosya sistemini boyutlandır (daraltılamaz, sadece genişletilir.)

## LV Küçültme (Boyut Azaltma)
#################################
# Uyarı! LV küçültme işlemi veri kaybına yol açabilir. Verilerinizi yedekleyin!

sudo umount /mnt/home                       # Önce unmount et
sudo e2fsck -f /dev/vg_name/lv_name         # Dosya sistemini kontrol et
sudo resize2fs /dev/vg_name/lv_name 15G     # Dosya sistemini küçült (15G)
sudo lvreduce -L 15G /dev/vg_name/lv_name   # LV boyutunu küçült
sudo mount /dev/vg_name/lv_name /mnt/home   # Tekrar mount et

## VG Genişletme (Yeni Disk Eklemek)
sudo pvcreate /dev/sdd                  # Yeni disk ekle
sudo vgextend vg_veri /dev/sdd          # VG'ye ekle

## VG'den PV'yi Çıkarma (vgreduce)
sudo vgreduce vg_veri /dev/sdd

## LVM Silme İşlemleri:
> LV Silme:
sudo umount /mnt/home
sudo lvremove /dev/vg_veri/lv_home

> VG Silme:
sudo vgremove vg_veri

> PV Silme:
sudo pvremove /dev/sdb

## LVM Metadata Yedekleme: (LVM config backup)
sudo vgcfgbackup -f /backup/vg_veri_backup vg_veri
sudo vgcfgrestore -f /backup/vg_veri_backup vg_veri
⚠️ Uyarı: Eski config varolan volume group ayarlarını bozabilir, dikkatli olunmalıdır.
```
```sh
## Advanced LVM Management:
-LVM Snapshot
-lvrename, vgrename, pvrename
-lvconvert
-thin provisioning
-LVM archive ve LVM backup
-LVM Caching
-
-
```
