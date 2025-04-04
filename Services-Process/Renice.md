# Linux Süreç Öncelik Yönetimi: `renice` Komple Kılavuzu

## Komut Tanımı ve Önem

`renice`, Linux sistemlerinde çalışan süreçlerin CPU öncelik değerlerini ("nice" değeri) dinamik olarak değiştiren bir komuttur. Bu komut, kaynak dağılımını optimize etmek ve süreçlerin önceliğini yönetmek için kullanılır. 

### Temel Özellikler:
- **Öncelik Aralığı**: -20 (en yüksek öncelik) ile 19 (en düşük öncelik)
- **Varsayılan Değer**: 0
- **Yetki Sistemi**:
  - Normal kullanıcılar: 0→19 (sadece öncelik düşürme)
  - Root (Yönetici): -20→19 (tam erişim)

## Temel Kullanım

`renice` komutu ile bir sürecin önceliği değiştirilir. Bu işlem için genellikle PID (process ID) veya kullanıcı/grup adı kullanılır.

### Öncelik Değiştirme (PID ile)
```bash
renice -n 10 -p 1234  # PID 1234'ün nice değerini 10 yap



# `renice` Komutu: Linux Süreç Öncelik Yönetimi Uzman Kılavuzu

## 📌 Komutun Temel Yapısı
```bash
renice [-n] <priority> [-p|--pid] <pid>... [-u|--user] <user>... [-g|--pgrp] <group>...
```

## Süreç Öncelik Ayarları
renice -n 5 -p 1234               # PID 1234'ün nice değerini 5 yap
sudo renice -n -10 -p $(pgrep nginx)  # Nginx süreçlerine yüksek öncelik

## Kullanıcı ve Grup Yönetimi:
sudo renice -n 15 -u apache       # Apache kullanıcısının tüm süreçleri
sudo renice -n -5 -g docker       # Docker grubuna öncelik ver

## Dinamik Öncelik Değişiklikleri
renice -n +2 -p 5678              # Mevcut değeri 2 artır
renice -n -3 -p 9012              # Mevcut değeri 3 azalt (root gerektirir)

## Toplu İşlemler:
# Tüm Python süreçlerini düşük öncelikli yap
pgrep -f python | xargs renice -n 19

# CPU kullanımı yüksek süreçleri arka plana al
ps -eo pid,%cpu --sort=-%cpu | head -n 5 | awk 'NR>1 {print $1}' | xargs renice -n 19

## Zamanlanmış Optimizasyon
# Gece yarısı öncelikleri otomatik düşür
echo "pgrep -f batch_job | xargs renice -n 15" | at 00:00

## Süreç Listeleme:
# Öncelik sırasına göre süreçleri listele
ps -eo pid,ni,cmd --sort=ni

# Detaylı süreç bilgisi
ps -eo pid,user,ni,pri,pcpu,pmem,cmd --sort=-pcpu | head -n 10

## Gerçek Zamanlı İzleme:
watch -n 1 'ps -eo pid,ni,cmd | head -n 15'  # Anlık izleme
htop  # Grafiksel arayüzde NI sütununu göster

## 
