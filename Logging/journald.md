journald is an advanced log management system. It collects logs from the kernel, boot processes and services and stores them as binary under /run/log/journal.
The logs collected by journald can be queried with the journalctl command. Journald logs are not permanent. 
When the system is restarted, it transfers the logs to rsyslogd. rsyslogd then distributes the logs to the relevant log files.
journald can write logs to specified files, manage logs remotely and provide log sending to log servers.

# Tüm günlükleri göster (en yeniden en eskiye, less ile sayfalanmış)
journalctl

# Sadece mevcut önyüklemedeki günlükleri göster
journalctl -b

# Sadece çekirdek mesajlarını göster (dmesg gibi)
journalctl -k

# Belirli bir servisin (unit) günlüklerini göster
journalctl -u sshd.service

# Belirli bir PID'ye ait günlükleri göster
journalctl _PID=1234

# Belirli bir zaman aralığındaki günlükleri göster
journalctl --since "yesterday"
journalctl --since "2023-10-26 10:00:00" --until "2023-10-26 11:00:00"

# Günlükleri canlı olarak takip et (-f: follow)
journalctl -f

# Hata (error) seviyesindeki ve daha kritik günlükleri göster (-p: priority)
journalctl -p err 
# Seviyeler: emerg (0), alert (1), crit (2), err (3), warning (4), notice (5), info (6), debug (7)

# Daha fazla örnek ve filtreleme seçeneği için: man journalctl
