# SSH Timeout:15 Minute
```
sudo visudo
Defaults:root timestamp_timeout=15
sudo visudo -c
```
or
```
cd /etc/sudoers.d/
nano 99-timeout.conf
Defaults:root timestamp_timeout=15
sudo chmod 99-timeout.conf
```

