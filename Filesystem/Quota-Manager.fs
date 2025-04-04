## Quota management:
sudo apt install quota quotatool
quota --version
sudo systemctl status quota

# Enabling Quota Support in the File System:
sudo nano /etc/fstab

# fstab file
>> /dev/sdc2    /home    ext4    defaults,usrquota,grpquota    0    2
# -------
# -------

usrquota: Enables user quota support.
grpquota: Enables group quota support.


# Creating Quota Files:
sudo quotacheck -cum /home
sudo quotacheck -ugm /home

-c: Create new quota file.
-u: Check user quota.
-g: Check group quota.
-m: Run file system in read-only mode without checking.

# View Quota Status:
sudo edquota -u faruk
quota -u faruk # Show user quota
repquota -a    # Show all  users quota
repquota /home # Show /home dir quota

sudo quotaon -v /home  # open quota system
sudo quotaoff -v /home # close the quota system
