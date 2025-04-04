# `renice` Komutu: Linux Süreç Öncelik Yönetimi Uzman Kılavuzu

## 📌 Komutun Temel Yapısı
```bash
renice [-n] <priority> [-p|--pid] <pid>... [-u|--user] <user>... [-g|--pgrp] <group>...
🔧 Kapsamlı Kullanım Örnekleri
Süreç Öncelik Ayarları
bash
Copy
renice -n 5 -p 1234               # PID 1234'ün nice değerini 5 yap
sudo renice -n -10 -p $(pgrep nginx)  # Nginx süreçlerine yüksek öncelik
Kullanıcı ve Grup Yönetimi
bash
Copy
sudo renice -n 15 -u apache       # Apache kullanıcısının tüm süreçleri
sudo renice -n -5 -g docker       # Docker grubuna öncelik ver
Dinamik Öncelik Değişiklikleri
bash
Copy
renice -n +2 -p 5678              # Mevcut değeri 2 artır
renice -n -3 -p 9012              # Mevcut değeri 3 azalt (root gerektirir)
🛠️ Sistem Yöneticisi İpuçları
Toplu İşlemler
bash
Copy
# Tüm Python süreçlerini düşük öncelikli yap
pgrep -f python | xargs renice -n 19

# CPU kullanımı yüksek süreçleri arka plana al
ps -eo pid,%cpu --sort=-%cpu | head -n 5 | awk 'NR>1 {print $1}' | xargs renice -n 19
Zamanlanmış Optimizasyon
bash
Copy
# Gece yarısı öncelikleri otomatik düşür
echo "pgrep -f batch_job | xargs renice -n 15" | at 00:00
📊 İzleme ve Analiz
Süreç Listeleme
bash
Copy
# Öncelik sırasına göre süreçleri listele
ps -eo pid,ni,cmd --sort=ni

# Detaylı süreç bilgisi
ps -eo pid,user,ni,pri,pcpu,pmem,cmd --sort=-pcpu | head -n 10
Gerçek Zamanlı İzleme
bash
Copy
watch -n 1 'ps -eo pid,ni,cmd | head -n 15'  # Anlık izleme
htop  # Grafiksel arayüzde NI sütununu göster
⚠️ Kritik Uyarılar ve Sınırlamalar
Sistem Kararlılığı:

Kernel süreçlerini ([kthreadd] vb.) değiştirmeyin

PID 1 (systemd) önceliğini değiştirmek sistem çökmelerine yol açabilir

Güvenlik Sınırları:

bash
Copy
# Kullanıcı limitlerini görüntüleme
grep '^ULIMIT' /etc/systemd/system.conf
ulimit -a
Çekirdek Parametreleri:

bash
Copy
# Kullanılabilir nice aralığını kontrol
sysctl -n kernel.sched_latency_ns
🔄 Alternatif Yöntemler
Sistemd Birimleri için
bash
Copy
systemctl set-property httpd.service CPUShares=512  # systemd hiyerarşik kontrol
cgroups ile
bash
Copy
cgcreate -g cpu:/mygroup
cgset -r cpu.shares=512 mygroup
📈 Performans Optimizasyonu
CPU Bağlama
bash
Copy
taskset -c 0,1 renice -n -5 -p 1234  # Belirli çekirdeklerde yüksek öncelik
IO Önceliği
bash
Copy
ionice -c 2 -n 5 renice -n 10 -p 1234  # IO önceliği ile kombine kullanım
🚨 Sorun Giderme ve Hata Çözümleri
Hata Durumu	Olası Neden	Çözüm
renice: setpriority: Operation not permitted	SELinux kısıtlaması	audit2allow ile politika oluştur
renice: failed to set priority for 1234: No such process	Zombie süreç	`ps aux	grep defunct` ile kontrol et
renice: invalid priority: 25	Aralık aşımı	-20 ile 19 arası değer kullan
📚 Ek Kaynaklar
bash
Copy
man 2 setpriority  # Sistem çağrısı dokümantasyonu
man 5 proc         # /proc/[pid]/stat nice değeri detayları
info sched         # Çekirdek zamanlayıcı algoritmaları
💡 Uzman Tavsiyesi: Üretim sistemlerinde değişiklik öncesi screen veya tmux oturumu açın ve sar -P ALL 1 10 ile CPU istatistiklerini kaydedin.
