# Proxy 
Proxy (vekil sunucu), istemci ile hedef sunucu arasında aracı görevi gören bir sunucudur. İstemcinin isteklerini alır, kendi adına hedef sunucuya iletir ve gelen yanıtı istemciye geri döndürür. Proxy, internette sizinle (istemci) ulaşmak istediğiniz hedef (sunucu/web sitesi) arasında duran bir aracıdır (middleman).
Türkçedeki "vekil" kelimesi aslında tam olarak ne yaptığını açıklar: Sizin adınıza vekâleten hareket eder.

Elbette, proxy türlerini temel kategorilere ayırarak, her biri için özet cümlelerle listeliyorum:

## 2. Yönüne Göre (En Temel Ayrım)
### Forward Proxy (İleri Yönlü Proxy):
Sizin (istemcinin) internete çıkmak için kullandığı ve kimliğinizi gizleyen vekil sunucudur.

### Reverse Proxy (Ters Yönlü Proxy):
Web sitesinin (sunucunun) önünde duran, gelen istekleri karşılayan ve sunucuyu koruyan vekil sunucudur.

## 2. Gizlilik Seviyesine Göre (Anonimlik)
### Transparent Proxy (Şeffaf Proxy):
Kimliğinizi (IP adresinizi) gizlemez, proxy olduğunu belli eder; genellikle filtreleme veya önbellekleme (caching) için kullanılır.

### Anonymous Proxy (Anonim Proxy):
Kimliğinizi gizler, ancak hedef sunucuya "ben bir proxy'yim" bilgisini gönderir.

### High Anonymity (Elite) Proxy (Yüksek Gizlilikli Proxy):
Hem kimliğinizi (IP) gizler hem de proxy olduğunu belli etmez; en güvenli gizlilik seviyesini sunar.

## 3. Protokole Göre (Teknik Ayrım)
### HTTP Proxy:
Sadece web trafiğini (HTTP ve HTTPS protokolleri) yönlendirmek için tasarlanmıştır.

### SOCKS Proxy (SOCKS4/5):
Protokolden bağımsızdır; web, oyun, e-posta, torrent gibi her türlü internet trafiğini yönlendirebilir.

### SSL Proxy (HTTPS Proxy):
Şifreli SSL/TLS trafiğini çözebilen, inceleyebilen ve yeniden şifreleyebilen (genellikle güvenlik duvarlarında kullanılan) gelişmiş bir proxy'dir.

## 4. IP Kaynağına ve Kullanım Amacına Göre
### Datacenter Proxy (Veri Merkezi Proxy):
Bir veri merkezindeki sunuculardan alınan, çok hızlı ancak kolayca "proxy" olarak tanınabilen IP adresleridir.

### Residential Proxy (Konut Proxy):
Gerçek ev interneti (ISS) kullanıcılarına ait IP adreslerini kullandırarak hedef siteler tarafından engellenmeyi zorlaştırır.

### Mobile Proxy (Mobil Proxy):
Sizi gerçek bir mobil (4G/5G) operatör ağından bağlanıyormuş gibi gösteren IP adresleri kullanır.

### Caching Proxy (Önbellekleyici Proxy):
Sık erişilen web içeriğini (resimler, siteler) hafızasında tutarak internet erişimini hızlandıran ve bant genişliğini azaltan bir proxy'dir.

### Web Proxy (Site Üzerinden Proxy):
Tarayıcınıza veya programınıza ayar yapmadan, sadece bir web sitesi üzerinden (genellikle bir form aracılığıyla) çalışan basit proxy hizmet
