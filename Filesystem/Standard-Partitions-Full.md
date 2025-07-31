
# 💾⚙️ Standard Partitions: [Install, Configure]

Standard disk configuration in Linux usually includes standard partitions. This configuration divides the hard disk into physically separated partitions and formats each as a separate file system. If Linux systems do not have LVM (Logical Volume Manager), standard partitions are used by default.

Standard partitions are used to separate physical disk spaces of a certain size and format each with a separate file system. These partitions may be directories containing system files or user data, such as /boot, /home, /var .etc.

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
[Standard Partitions - Install, Configure, Manage -farukguler.com](https://farukguler.com/posts/standard-partitions-install-configure-manage/)
