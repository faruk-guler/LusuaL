# 📜 Tutorials / Information:
```sh


LVM:
⦁ The highest number of physical volumes within each volume group is 256.
⦁ LVM size is minimum 4MB and maximum 255.99GB.
⦁ The maximum volume group (VG) per device is 99.
⦁ Traditional partitioning is good, but LVM is better. (RedHat Enterprise)
⦁ XFS file system can be expanded but not reducing!! (year 2024) The only solution is to back up the data, delete the volume, create a smaller volume and restore the data there.
⦁ Disk reducing is not recommended. If the reducing is greater than the disk capacity, you will lose data!!
⦁
⦁

- LV: Cannot belong to more than one VG.
- VG: Can contain more than one LV.
- PV: Cannot belong to more than one VG.
- VG: Can consist of more than one PV.

```