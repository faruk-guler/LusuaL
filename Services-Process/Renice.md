# `renice` Komutu: Linux Süreç Öncelik Yönetimi Uzman Kılavuzu

## 📌 Komutun Temel Yapısı
```bash
renice [-n] <priority> [-p|--pid] <pid>... [-u|--user] <user>... [-g|--pgrp] <group>...

renice -n 5 -p 1234               # PID 1234'ün nice değerini 5 yap
sudo renice -n -10 -p $(pgrep nginx)  # Nginx süreçlerine yüksek öncelik
