## Time Management:
Proper time management in Linux systems is essential for consistency of system logs, correct operation of scheduled tasks, and network synchronization.
Keeping the hardware clock and system clock in sync, configuring time zone settings correctly, and synchronizing with NTP tools increases system reliability and performance.

# Key Concepts.
Hardware Clock (RTC): Clock stored in BIOS/UEFI (powered by CMOS battery).
System Clock: Clock obtained from hardware clock and managed by kernel when operating system starts.
Timezone: Regional setting that determines local time (e.g. Europe/Istanbul for Turkey).
NTP (Network Time Protocol): Protocol that provides time synchronization over the Internet.

##### View System Time and Date:
date
timedatectl
timedatectl status
timedatectl list-timezones
timedatectl list-timezones | grep -i istanbul
timedatectl set-timezone Europe/Istanbul

##### Manuel:
sudo date -s "2025-03-06 09:50:00"
sudo timedatectl set-time '2025-03-06 14:30:00'

```sh
# Hardware Clock (RTC)
sudo timedatectl | grep "RTC in local TZ"
sudo hwclock --show

sudo hwclock --systohc [System time to > Hardware RTC]
sudo hwclock --hctosys [Hardware time to > System]
```

## Synchronization with NTP: [systemd-timesyncd, chrony, ntp]
timedatectl status
timedatectl set-ntp on [NTP on]

```sh
# Using systemd-timesyncd [Default Already]
sudo apt update
sudo apt install systemd-timesyncd
systemctl status systemd-timesyncd
systemctl start systemd-timesyncd
systemctl enable systemd-timesyncd
systemctl disable systemd-timesyncd

nano /etc/systemd/timesyncd.conf
sudo timedatectl set-ntp true  # For NTP Enabled
sudo timedatectl set-ntp false # For NTP Disabled
```

##### ----------------------------------------
Basic Synchronization: Systemd-timesyncd
Flexible and Powerful: Chrony
Detailed and Advanced: Ntpd

https://farukguler.com/posts/centos8-ntp-server-and-clients-best-configuration/
https://farukguler.com/posts/best-client-ntp-services-configuration/
https://farukguler.com/posts/ntp-settings-automated/
