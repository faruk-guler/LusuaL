
# LVM Logical Volume Management -farukguler.com

Mantıksal Birim Yöneticisi (LVM), Linux sistemlerinde depolama yönetiminde esneklik sağlayan bir disk soyutlama katmanıdır. LVM, fiziksel diskleri soyutlayarak mantıksal bir depolama havuzu oluşturur ve bu havuzdan esnek mantıksal diskler (mantıksal birimler) tahsis etmenize olanak tanır. Bu, depolama alanınızı daha esnek bir şekilde yönetmenize, genişletmenize veya daraltmanıza imkan verir.

## LVM Mimarisi:
<p align="left">
  <img src="https://farukguler.com/assets/post_images/lvm-best.jpg" alt="LVM Logo" width="500"/>
</p>

```sh
#Install:
sudo apt install lvm2         # Debian/Ubuntu
sudo yum install lvm2         # RHEL/CentOS
sudo zypper install lvm2      # SUSE/openSUSE:

#LVM Configuration:
/etc/lvm/lvm.conf

## LV Yolları ve Alternatifler:
/dev/vg_name/lv_name           # Standart yol
/dev/mapper/vg_name-lv_name    # Device mapper yolu
/dev/dm-N                      # Düşük seviye device mapper aygıtı
```
[Standard Partitions - Install, Configure, Manage](https://farukguler.com/posts/standard-partitions-install-configure-manage/)
