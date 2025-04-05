
<!-- wp:image {"id":4522,"width":"474px","height":"auto","sizeSlug":"large","linkDestination":"none","className":"is-resized"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/sync-time-linux-servers-chrony-1.jpeg?w=1024" alt="" class="wp-image-4522" style="width:574px;height:auto" /></figure>


<!-- wp:paragraph -->
<p>Bu makalede Domain ortamınızda çalışan tüm cihazların <strong>Tarih &amp; Saat senkronizasyonu</strong>nu standart bir duruma getirebilmeniz için gerekli olan merkezi yönetebildiginiz bir <strong>Centos 8</strong> <strong>NTP server</strong> kurulumunu yapacağız.<br><strong>"2</strong>" adet <strong>"Windows Domain Controller ve Ubuntu 20.04"  </strong>zaman senkronizasyonu sağlamak için kullanılan araçlardan<strong> "NTP Chrony" </strong>servisine yönlendireceğiz. <br>Centos 8 üzerine özellikle Chrony servisi kurulacaktır. bu servis daha az Memory kullanır ve gerektiği zaman CPU kullanıp güç tasarrufu sağlar.<br>Yerel ağınızda son derece hassas saat senkronizasyonu sağlayan donanımsal zaman damgasını destekler.<strong> *** "NTP servisi default UDP/123 olarak çalışır"</strong></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>Bazı popüler zaman senkronizasyonu araçları:</strong></p>
<!-- /wp:paragraph -->

<!-- wp:list {"ordered":true} -->
<ol class="wp-block-list"><!-- wp:list-item -->
<li><strong>NTP (Network Time Protocol)</strong>: Chrony'nin en yaygın muadili, geleneksel NTP istemcisidir. Ubuntu'da genellikle "ntp" veya "ntpdate" paketleriyle temsil edilir.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>Chrony</strong>: Chrony, Network Time Protocol (NTP) için modern ve hassas bir zaman senkronizasyonu istemcisidir. Chrony, geleneksel NTP istemcilerine göre daha hassas zaman senkronizasyonu sağlama yeteneği ve düşük kaynak tüketimi ile öne çıkar. Ubuntu ve diğer birçok Linux dağıtımında yaygın olarak kullanılır. Aynı zamanda Raspberry Pi gibi küçük cihazlarda da tercih edilir.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>systemd-timesyncd</strong>: Ubuntu gibi bazı Linux dağıtımlarında varsayılan olarak gelen "systemd-timesyncd," zaman senkronizasyonunu sağlamak için kullanılan daha modern bir NTP istemcisidir. Chrony'ye göre daha hafif ve basittir.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>ntpd</strong>: "ntpd" veya "ntpd" paketi, geleneksel NTP protokolünü kullanan bir diğer NTP istemcisidir. "ntpd" genellikle CentOS veya RHEL gibi dağıtımlarda kullanılır.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>w32time</strong>: Windows işletim sistemi için zaman senkronizasyonunu sağlayan bir servistir. Windows sunucularında zamanın senkronize edilmesi gerektiğinde kullanılır.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>Vetinari</strong>: Vetinari, yüksek hassasiyetli ve güvenilir zaman senkronizasyonu sağlayan bir NTP istemcisidir. Özellikle bilimsel ve araştırma uygulamaları için kullanılır.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>OpenNTPD</strong>: OpenNTPD, OpenBSD projesi tarafından geliştirilen basit ve güvenilir bir NTP istemcisidir. OpenBSD ve bazı diğer BSD tabanlı işletim sistemlerinde kullanılır</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>.vs</strong></li>
<!-- /wp:list-item --></ol>
<!-- /wp:list -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>***Server Yapılandırması:</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p><strong>Chrony </strong>saat senkronizasyon servisini Centos8 üzerine yükleyelim.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">dnf check-update
dnf update
dnf install chrony -y</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Yükleme sonrasında servisi start etmek ve durumunu görüntülemek için aşağıdaki komutları kullanalım</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">systemctl start chronyd<br>systemctl status chronyd<br><br><strong>#Chronyd servisi aktif et</strong><br>systemctl enable chronyd</pre>
<!-- /wp:preformatted -->

<!-- wp:image {"id":4491,"width":"858px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/active_ntp.png?w=1024" alt="" class="wp-image-4491" style="width:858px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>Chrony </strong>kurulumunu sonunda NTP Server 'in kurum dışındaki hangi zaman sunucularından saat senkronizasyonunu yapacağını ve ortamımızdaki hangi networklere NTP hizmeti vereceğini ayarlayacağız.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>#ilk olarak Chrony servisi config dosyasını editleyelim</strong>
nano /etc/chrony.conf

<strong>#Ülkemizin NTP hizmeti veren bazı sunucularının güncel 
listesini aşağıdaki linkten görelim.</strong>

#link <strong>https://www.pool.ntp.org/zone/tr</strong>
server 0.tr.pool.ntp.org iburst
server 1.tr.pool.ntp.org iburst
server 2.tr.pool.ntp.org iburst
server 3.tr.pool.ntp.org iburst

<strong>Global</strong>
time.google.com
time.cloudflare.com
time.windows.com
time.facebook.com
time.apple.com
time.nist.gov</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p><strong>Chrony </strong>servisi config dosyasını editlemeye devam ediyoruz. toplamda 2 satırı değiştirmemiz gerekiyor.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>#bu 1. alanda Ülkemizin NTP hizmeti veren sunucularını ekleyelim!</strong>

<strong># Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).</strong>

server 0.tr.pool.ntp.org iburst
server 1.tr.pool.ntp.org iburst
server 2.tr.pool.ntp.org iburst
server 3.tr.pool.ntp.org iburst</pre>
<!-- /wp:preformatted -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>#bu alanda NTP hizmeti alacak Network ve WLAN yapınızı eklemeniz gerekir</strong>!<br><br><strong>#Allow NTP client access from local network.</strong><br>allow 10.5.10.0/24<br>allow 10.4.10.0/24<br>allow 192.168.1.0/24<br>allow 10.5.20.0/24</pre>
<!-- /wp:preformatted -->

<!-- wp:image {"id":4496,"width":"657px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/country_ntp.png?w=803" alt="" class="wp-image-4496" style="width:657px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>Chrony servisini RESTART edelim.</strong>
systemctl restart chronyd

<strong>#gerekli Firewal kurallarına izin verelim.</strong>
sudo firewall-cmd --permanent --add-service=ntp

<strong>#firewall servisini yeniden başlatalım.</strong>
sudo firewall-cmd --reload

#<strong>Chrony servis durumumu kontol edelim.</strong>
systemctl status chronyd</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p>Chrony servisinin, birlikte ayarladığımız dış dünyadaki NTP sunucuları ile iletişim kurup kurmadığını ve aralarındaki saat senkronizasyon ayarlarının durumunu&nbsp;<strong>sources</strong>&nbsp;ve&nbsp;<strong>tracking</strong>&nbsp;komutları ile görebilirsiniz.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>#Size en yakın NTP  kaynağını görmek için</strong>
chronyc sources

<strong>#tracking komut ile bu bağlantıların ayrıntılarını gözlemleyebilirsiniz.</strong>
chronyc tracking

<strong>#bağlı olduğu NTP serverlar ile arasındaki sapma oranı ve offset bilgisi için</strong>
chronyc sourcestats

<strong>#kullanılan NTP sunucuları için bildirilen zaman damgası modlarını görmek için</strong>
chronyc ntpdata

<strong>#Centos8 NTP sunucumuzun güncel tarih ve saatini görmek için</strong>
date

<strong>#NTP sunucumuza bağlanıp tarih saat çeken sunucu ve cihazları görmek için()</strong>
chronyc clients</pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>***Client Yapılandırması:</strong></h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p><strong>Aşama 1: </strong>Bu aşamada bir Ubuntu 20.04 sunucumuzu hazırlamış olduğumuz NTP server'e yönlendirip Tarih &amp; Saat ayarlarını çekmesini sağlayacağız. Ubuntu Sunucularda genellikle varsayılan olarak <strong>"systemd-timesyncd" </strong>yüklü gelir. Ancak, yapılandırma dosyasını düzenlemek gerekebilir.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong># "systemd-timesyncd" Servis Durumunu Kontrol Et:</strong>
sudo systemctl status systemd-timesyncd

<strong>#Varsayılan Ubuntu NTP Yapılandırma dosyasını aç:</strong>
sudo nano /etc/systemd/timesyncd.conf

<strong>#Dosyaya satırı ekleyin, Default:"ntp.ubuntu.com" "185.125.190.56"</strong>
<strong>NTP=</strong>centos-ntp.guler.com

<strong>#Bölgeleri Listele ve Seç</strong>
timedatectl list-timezones
sudo timedatectl set-timezone Turkey

<strong>#Configure to Firewall</strong>
sudo ufw allow from any to any port 123 proto udp

<strong>#systemd-timesyncd servisini yeniden başlat:</strong>
sudo systemctl restart systemd-timesyncd

<strong>#Sistem başlangıcında otomatik olarak başlaması için:</strong>
sudo systemctl enable systemd-timesyncd

<strong>#NTP senkronizasyon durumunu kontrol et:</strong>
timedatectl timesync-status &amp; timedatectl status

<strong>#NTP servisini Enable\Disable et</strong>
#timedatectl set-ntp true
#timedatectl set-ntp off</pre>
<!-- /wp:preformatted -->

<!-- wp:image {"id":8543,"width":"678px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/time_date_status.png?w=902" alt="" class="wp-image-8543" style="width:678px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul class="wp-block-list"><!-- wp:list-item -->
<li><strong>"Server: 40.119.148.38 (centos-ntp.guler.com)": </strong>Bu, NTP sunucusunun IP adresini ve adını gösterir. Bu durumda, NTP sunucusu "centos-ntp.guler.com"<strong> </strong>olarak belirlenmiştir.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>"Local time: </strong>Sat 2023-09-09 00:40:45 +03": Bu, yerel zamanı ve saat dilimini gösterir.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>"Time zone: </strong>Turkey (+03, +0300)": Bu, sistem saat dilimini ve saat dilimi ofsetini gösterir. Türkiye saat diliminde (+03) bulunur.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>"NTP service: active": </strong>Bu, NTP hizmetinin etkin olduğunu gösterir. Sistem zamanı NTP sunucusu ile senkronize ediliyor.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li><strong>"RTC in local TZ: no": </strong>Bu, sisteminizdeki RTC <strong>(Real-Time Clock) </strong>yongasının yerel saat dilimine göre ayarlanmadığını gösterir. RTC, genellikle anakartta bulunan bir saat yongasıdır ve sistem güç kapalıyken bile zamanı tutar.</li>
<!-- /wp:list-item --></ul>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p><strong>Aşama 2: </strong>Bu aşamada ise bir Windows Server 2019 DC sunucumuzu hazırlamış olduğumuz NTP server'e yönlendirip Tarih &amp; Saat ayarlarını çekmesini, dolayısıyla tüm domain ortamının NTP Senkronizasyonunu sağlayacağız.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Öncelikle DNS üzerinde NTP sunucunuz için bir<strong> Host (A) </strong>kaydı oluşturalım. Amacımız ise eğer NTP sunumuzun ip adresi değişirse bunun uygulanan tüm client 'lerde düzenlemenin önüne geçmiş olmaktır.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Ben <strong>centos-ntp.guler.com</strong> isimli bir kayıt oluşturup NTP sunucumun IP adresine yönlendirdim. &gt;&gt; <strong>centos-ntp.guler.com</strong> <strong>10.5.10.50</strong></p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":4503,"width":"776px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/ntp-dns.png?w=1024" alt="" class="wp-image-4503" style="width:776px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p>Şimdi <strong>Powershell</strong> ile DC sunucumuzu <strong>CentOS8 centos-ntp.guler.com</strong> <strong>10.5.10.50</strong> NTP servere yönlendirme işlemini yapalım.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>PS:</strong>
<strong>w32tm /config /manualpeerlist:centos-ntp.guler.com /syncfromflags:MANUAL /reliable:YES /update</strong>

The command completed successfully.
PS C:\Windows\system32&gt;</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p><strong>PS:</strong></p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>#yeni girilen ayarların güncellenmesini sağlayalım.</strong>
w32tm /config /update

<strong>#Windows time servisini yeniden başlatalım.</strong>
Restart-Service w32time

<strong>#Veya servisi durdurup yeniden başlatabilirsiniz.</strong>

Stop-Service w32time
Start-Service w32time

<strong>#zaman bilgisinin anlık olarak güncellemesi için aşağıdaki komutu kullanalım.</strong>
w32tm /resync /nowait

<strong>#Yeni tanımladığımız</strong>(centos-ntp.guler.com) <strong>NTP serveri kontrol edelim</strong>.
w32tm /query /configuration

<strong>#Sadece Tarih &amp; Saat kaynağını görüntülemek için</strong>
w32tm /query /source
w32tm /query /status

<strong>#Eğer birden çok NTP server adresi girdi iseniz.</strong>
w32tm /query /peers</pre>
<!-- /wp:preformatted -->

<!-- wp:image {"id":4516,"width":"858px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/actived_ntp.png?w=934" alt="" class="wp-image-4516" style="width:858px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>Görsel:</strong></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Son olarak ise Centos8 üzerinde NTP sunucunuza bağlı <strong>Windows Server 2019 DC </strong>ve <strong>Ubuntu 20.04</strong> sunucunuzun IP adresini görüyor olduğumuzu teyit edelim.</p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>sudo chronyc clients</strong><br><br><strong>#Hostname                     NTP   Drop Int IntL Last     Cmd   Drop Int  Last<br>=============================================================================<br>10.5.10.10                     12      0   7   -    11       0      0   -    -</strong><br><br>[root@localhost ~]# nslookup anatolia<br><br><strong>################################<br>Name:   anatolia.guler.com<br>Address: 10.5.10.10</strong></pre>
<!-- /wp:preformatted -->

<!-- wp:image {"id":4514,"width":"838px","height":"auto","sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/verify_ntp.png?w=1024" alt="" class="wp-image-4514" style="width:838px;height:auto" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>Son olarak güncel saatimizi doğrulayalım.</strong></p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>&gt;&gt;&gt;&gt; <strong>https://time.is</strong></p>
<!-- /wp:paragraph -->

<!-- wp:image {"id":5535,"sizeSlug":"large","linkDestination":"none","className":"is-resized"} -->
<figure class="wp-block-image size-large is-resized"><img src="https://farukguler.com/assets/post_images/time-is.png?w=1024" alt="" class="wp-image-5535" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>Faydalı olması dileğiyle. – Hope it will be useful</strong>.</p>
<!-- /wp:paragraph -->


## Kaynaklar
- https://farukguler.com/posts/best-client-ntp-services-configuration/
- https://farukguler.com/posts/centos8-ntp-server-and-clients-best-configuration/

