# 📜 Tutorials / Information:

# Standard Partitions:
```sh
⦁ Disks can be divided into partitions.
⦁ Partitions are logical sections within a disk. Each section can be formatted with a separate file format.
⦁ Formatting must be done separately for each partition after partitioning. otherwise you will lose all partitions.
⦁ If Linux systems do not have LVM (Logical Volume Manager), standard partitions are used by default.
⦁ Discs always expand to the right.
⦁ The disk is set to GPT (1-128), you can create 128 partitions.
⦁ LVM Management will place the /boot partition in the first sector.
⦁ In best practice, /boot and /swap should be placed in the first sector.
⦁ The created file systems (xfs, ext3, ext4, ntfs .etc) require a partition. It is mandatory to use these partitions.
⦁ It is a safer approach to mount the UUID of the fstab /boot partition.
⦁ Expanding and reducing the partition can be done Online/Offline.
⦁ To reduce the partition, the File system must be minimized first. (reverse process of expansion)
⦁ If enlarging a file system is to be done, it should first start from the partition.
⦁ The file system cannot be enlarged without enlarging the partition
⦁ The "parted" or cfdisk" tool can be used to expand the partition.
⦁ Actually no resize partition option in fdisk tool! (year 2024)
⦁ "e2fsck" checker should be used before reducing  the partition.
⦁ xfs file system can be expanded but not reducing!! (year 2024)
⦁ Disk reducing is not recommended. If the reducing is greater than the disk capacity, you will lose data!!
⦁ There are two types of disks used in the Linux world. Active partitions and Logical partitions
⦁ The active partition must be primary.
⦁ "Primary partitions" "can be active partition"
⦁ "Extended partition" will not be an active partition
⦁ The NTFS disk format can be used for dual booting on a Linux system.
⦁ To repair the file system with e2fsck, the file system must be unmounted.
⦁
⦁
```

# LVM (Logical Volume Management):
```sh
⦁ The highest number of physical volumes within each volume group is 256.
⦁ LVM size is minimum 4MB and maximum 255.99GB.
⦁ The bootloader cannot read LVM volumes directly. Therefore, you need to create your /boot partition on a standard (non-LVM) partition and define it in the fstab file. Skipping this step may cause your system to fail to boot after LVM migration. You may need to use an external live disk image to resolve this situation.
⦁ The maximum volume group (VG) per device is 99.
⦁ Traditional partitioning is good, but LVM is better. (RedHat Enterprise)
⦁ In the default installation, the [/] and [swap] partitions are always created in LVM, and the [/boot] partition is created in a separate Standard Partition.
⦁ XFS file system can be expanded but not reducing!! (year 2024) The only solution is to back up the data, delete the volume, create a smaller volume and restore the data there.
⦁ Disk reducing is not recommended. If the reducing is greater than the disk capacity, you will lose data!!
⦁
⦁

- LV: Cannot belong to more than one VG.
- VG: Can contain more than one LV.
- PV: Cannot belong to more than one VG.
- VG: Can consist of more than one PV.

```