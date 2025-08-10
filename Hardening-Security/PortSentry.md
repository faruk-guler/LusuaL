# PortSentry Nedir?

**PortSentry**, ağ güvenliği için geliştirilmiş, **port taramalarını tespit eden** ve isteğe bağlı olarak bu taramaları engelleyebilen bir güvenlik aracıdır.

## 📌 Temel Amacı
Bir saldırganın sisteminizde hangi portların açık olduğunu anlamak için yaptığı **port taramalarını (port scan)** algılamak ve yanıt vermek.

---

## 🔍 Çalışma Mantığı
1. **Dinleme**  
   - PortSentry belirli portları dinler (bunlar genellikle kullanılmayan portlardır).
2. **Tespit**  
   - Birisi bu portlara bağlanmaya çalışırsa, bunun port taraması olabileceğini algılar.
3. **Tepki**  
   - Saldırganın IP adresini otomatik olarak firewall’a ekleyerek engelleyebilir (`iptables`, `hosts.deny` vb.).
   - Log tutar ve uyarı verir.

---

## 🛠 Özellikler
- TCP ve UDP taramalarını algılar  
- Syn scan, connect scan, stealth scan gibi yöntemleri tespit eder  
- Otomatik olarak **iptables** veya `/etc/hosts.deny` ile IP engelleme  
- Hafif ve düşük sistem kaynağı kullanımı

---

## 💡 Kullanım Senaryoları
- Sunucunuzun **tarandığını erken fark etmek**  
- Basit **IPS (Intrusion Prevention System)** gibi çalışarak saldırgan IP’yi engellemek  
- Diğer güvenlik araçlarıyla (Fail2Ban, Snort, Wazuh) entegre çalışmak

---

## 🔄 Alternatifler
- **Fail2Ban** – Daha çok brute-force engellemede yaygın  
- **PSAD** – Port Scan Attack Detector  
- **Snort / Suricata** – Daha kapsamlı IDS/IPS
