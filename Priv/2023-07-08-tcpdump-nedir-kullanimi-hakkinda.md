<!-- wp:image {"id":7555,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://farukguler.com/assets/post_images/tcpdump-logo.jpg?w=450" alt="" class="wp-image-7555" /></figure>
<!-- /wp:image -->

<!-- wp:paragraph -->
<p><strong>Tcpdump,</strong> ağ trafiğini izlemek, analiz etmek ve yakalamak için kullanılan bir komut satırı tabanlı bir araçtır. İlk olarak UNIX ve UNIX benzeri işletim sistemlerinde kullanılan Tcpdump, ağ paketlerini yakalayarak, ağ trafiğini analiz etmenizi sağlar. Bu, ağ sorunlarını teşhis etmek, ağ güvenliğini denetlemek veya ağa giren veya çıkan verileri incelemek gibi birçok amaç için kullanılabilir.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p>Tcpdump, ağ arabirimini dinleyerek geçen ağ paketlerini yakalar ve bunları insan tarafından okunabilir bir formatta sunar. Bu, farklı ağ protokollerine (TCP, UDP, ICMP, IP, vb.) ve ağ katmanına (Ethernet, WiFi, vb.) bağlı olarak çalışabilir.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>Tcpdump, genellikle aşağıdaki gibi çeşitli parametrelerle kullanılır:</strong></p>
<!-- /wp:paragraph -->

<!-- wp:list {"ordered":true} -->
<ol><!-- wp:list-item -->
<li>İnterface: İzlenecek olan ağ arabirimini belirtir. Örneğin, "eth0" veya "wlan0" gibi bir ağ arabirimi adı kullanılır.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li>Filtrasyon: Yalnızca belirli paketleri yakalamak için kullanılan filtrelerdir. Bu, belirli bir IP adresi veya protokolü filtrelemek, belirli bir port numarasına sahip paketleri yakalamak veya belirli bir veri paketi biçimine sahip paketleri yakalamak gibi çeşitli filtreler kullanabilirsiniz.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li>Sayı: Yakalanacak paket sayısını belirtir. Varsayılan olarak, Tcpdump sonsuz bir şekilde paketleri yakalamaya devam eder, ancak belirli bir sayıda paket yakalamak istiyorsanız, bu parametreyi kullanabilirsiniz.</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li>Dosya: Yakalanan paketleri bir dosyaya kaydetmek için kullanılır. Bu, yakalanan trafiği daha sonra analiz etmek veya başka bir araca aktarmak için kullanışlı olabilir.</li>
<!-- /wp:list-item --></ol>
<!-- /wp:list -->

<!-- wp:paragraph -->
<p>Tcpdump, ağ trafiği üzerinde gerçek zamanlı izleme, paketleri filtreleme, protokol analizi ve ağ güvenliği denetimi gibi birçok kullanım senaryosuna uygundur. Ancak, doğru bir şekilde kullanmak için ağ protokollerini ve Tcpdump'un sunduğu filtreleme seçeneklerini anlamak önemlidir.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph -->
<p><strong>Eğer işletim sisteminizde "TCPdump" yüklü değilse, onu paket yöneticisi kullanarak veya kaynak kodunu indirip derleyerek kurmanız gerekebilir. İşletim sisteminize bağlı olarak kurulum yöntemleri değişebilir.</strong></p>
<!-- /wp:paragraph -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>#Ubuntu/Debian:
apt-get update
apt-get install tcpdump</strong></pre>
<!-- /wp:preformatted -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>#Centos/RHEL:
sudo yum update
sudo yum install tcpdump</strong></pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>#Kullanımı:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted">#ana kullanım komutu:
<strong>tcpdump</strong>

#tcpdump hakkında detaylı bilgi:
<strong>man tcpdump</strong></pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>Capture-Yakalama Komutları:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>KOMUT           ÖRNEK KULLANIM                          AÇIKLAMA</strong>
-i any           <strong>tcpdump -i any </strong>                      Tüm arabirimlerden yakalar; süper kullanıcı izni gerekebilir (sudo/su)
-i eth0          <strong>tcpdump -i eth0 </strong>                     eth0 arabiriminden yakalar
-c count         <strong>tcpdump -i eth0 -c 5</strong>                 Belirli sayıda paket alındıktan sonra durur (örneğin, -c 5 ile 5 paket alındıktan sonra durur)
-r captures.pcap <strong>tcpdump -i eth0 -r captures.pcap</strong>     Kaydedilmiş yakalama dosyasını okur ve analiz eder
tcp              <strong>tcpdump -i eth0 tcp</strong>                  Sadece TCP paketlerini gösterir
udp              <strong>tcpdump -i eth0 udp  </strong>                Sadece UDP paketlerini gösterir
icmp             <strong>tcpdump -i eth0 icmp </strong>                Sadece ICMP paketlerini gösterir
ip              <strong> tcpdump -i eth0 ip </strong>                  Sadece IPv4 paketlerini gösterir
ip6              <strong>tcpdump -i eth0 ip6</strong>                  Sadece IPv6 paketlerini gösterir
arp              <strong>tcpdump -i eth0 arp</strong>                  Sadece ARP paketlerini gösterir
rarp             <strong>tcpdump -i eth0 rarp</strong>                 Sadece RARP paketlerini gösterir
slip             <strong>tcpdump -i eth0 slip</strong>                 Sadece SLIP paketlerini gösterir
-I               <strong>tcpdump -i eth0 -I</strong>                   Arabirimi monitör modunda kullanır
-K               <strong>tcpdump -i eth0 -K</strong>                   İletinin doğrulama toplamını kontrol etmez
-p               <strong>tcpdump -i eth0 -p </strong>                  İzinsiz modda yakalama yapmaz
</pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>Filtreleme Komutları:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>FİLTRE İFADESİ          AÇIKLAMA</strong>
src host 127.0.0.1      Kaynak IP/hostname 127.0.0.1 olan paketleri filtreler
dst host 127.0.0.1      Hedef IP/hostname 127.0.0.1 olan paketleri filtreler
host 127.0.0.1          Kaynak veya hedef IP/hostname 127.0.0.1 olan paketleri filtreler
ether src 01:23:45:AB:CD:EF  Kaynak MAC 01:23:45:AB:CD:EF olan paketleri filtreler
ether dst 01:23:45:AB:CD:EF  Hedef MAC 01:23:45:AB:CD:EF olan paketleri filtreler
ether host 01:23:45:AB:CD:EF Kaynak veya hedef MAC 01:23:45:AB:CD:EF olan paketleri filtreler
src net 127.0.0.1       Kaynak ağ konumu 127.0.0.1 olan paketleri filtreler
dst net 127.0.0.1       Hedef ağ konumu 127.0.0.1 olan paketleri filtreler
net 127.0.0.1           Kaynak veya hedef ağ konumu 127.0.0.1 olan paketleri filtreler
net 127.0.0.1/24        Kaynak veya hedef ağ konumu 127.0.0.1 ve 24 bitlik alt ağ maskesi olan paketleri filtreler
src port 80             Kaynak portu 80 olan paketleri filtreler
dst port 80             Hedef portu 80 olan paketleri filtreler
port 80                 Kaynak veya hedef portu 80 olan paketleri filtreler
src portrange 80-400    Kaynak port aralığı 80-400 olan paketleri filtreler
dst portrange 80-400    Hedef port aralığı 80-400 olan paketleri filtreler
portrange 80-400        Kaynak veya hedef port aralığı 80-400 olan paketleri filtreler
</pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>Görüntüleme Komutları:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>KOMUT   ÖRNEK KULLANIM                   AÇIKLAMA</strong>
-A      <strong>tcpdump -i eth0 -A</strong>              Her paketi (bağlantı düzeyi başlığı hariç) ASCII olarak görüntüler
-D      <strong>tcpdump -D</strong>                      Sistemde mevcut olan ağ arabirimlerinin listesini görüntüler
-e      <strong>tcpdump -i eth0 -e</strong>              Her çıktı satırında bağlantı düzeyi başlığını (Ethernet, IEEE 802.11 gibi) görüntüler
-F      <strong>tcpdump -i eth0 -F params.conf</strong>  Filtre ifadesi için params.conf dosyasını kullanır
-n      <strong>tcpdump -i eth0 -n</strong>              Adresleri isimlere çevirmez
-S      <strong>tcpdump -i eth0 -S</strong>              TCP dizin numaralarını mutlak olarak (göreli değil) görüntüler
</pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>Çıktı Komutları:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>KOMUT           ÖRNEK KULLANIM                         AÇIKLAMA</strong>
-w captures.pcap <strong>tcpdump -i eth0 -w captures.pcap</strong>       Yakalanan paketleri captures.pcap dosyasına kaydeder
-d               <strong>tcpdump -i eth0 -d</strong>                      İnsan tarafından okunabilir formu standart çıktıda görüntüler
-L               <strong>tcpdump -i eth0 -L</strong>                      Arabirim için veri bağlantı türlerini görüntüler
-q               <strong>tcpdump -i eth0 -q</strong>                      Hızlı/ sessiz çıktı. Daha az protokol bilgisi görüntüler
-U               <strong>tcpdump -i eth0 -U -w out.pcap</strong>           Paketleri out.pcap dosyasına gerçek zamanlı olarak yazar
</pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>Ek Komutlar:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>OPERATÖR     SÖZ DİZİMİ            ÖRNEK                                     AÇIKLAMA</strong>
AND           and, &amp;&amp;              <strong>tcpdump -n src 127.0.0.1 and dst port 21</strong>   "Ve" mantıksal operatörü ile birleştirilen filtre seçeneklerini uygular
OR            or, ||               <strong>tcpdump dst 127.0.0.1 or src port 22</strong>       "Veya" mantıksal operatörü ile birleştirilen herhangi bir koşulu eşleştirir
EXCEPT        not, !               <strong>tcpdump dst 127.0.0.1 and not icmp</strong>          "Değil" mantıksal operatörü ile başlayan bir koşulu ters çevirir
LESS          less, &lt;, (&lt;=)        <strong>tcpdump dst host 127.0.0.1 and less 128</strong>    Belirtilen uzunluktan (128) daha kısa paketleri eşleştirir
GREATER       greater, &gt;, (&gt;=)     <strong>tcpdump dst host 127.0.0.1 and greater 64</strong>  Belirtilen uzunluktan (64) daha uzun paketleri eşleştirir
EQUAL         =, ==                <strong>tcpdump host 127.0.0.1 = 0</strong>                  Uzunluğu sıfır olan paketleri eşleştirir
</pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>Ek Komutlar 2:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>KOMUT   ÖRNEK KULLANIM                   AÇIKLAMA</strong>
-K                      <strong>tcpdump -i eth0 -K</strong>                        İletinin doğrulama toplamını kontrol etmeyi devre dışı bırakır
-p                      <strong>tcpdump -i eth0 -p</strong>                        İzinsiz modda yakalamayı devre dışı bırakır
-t                      <strong>tcpdump -i eth0 -t</strong>                        Her çıktı satırında zaman damgasını görüntülemeyi devre dışı bırakır
-n                      <strong>tcpdump -i eth0 -n</strong>                        Adresleri isimlere çevirmeyi devre dışı bırakır
-S                      <strong>tcpdump -i eth0 -S</strong>                        TCP dizin numaralarını mutlak değil, göreli olarak görüntüler
-tt                     <strong>tcpdump -i eth0 -tt</strong>                       Her satırda, saniye cinsinden tarih ve saat bilgisini ve o zamandan beri geçen süreyi görüntüler
-XX                     <strong>tcpdump -i eth0 -XX</strong>                       Paketlerin başlıklarını ve verilerini onaltılık ve ASCII formatında görüntüler
</pre>
<!-- /wp:preformatted -->

<!-- wp:heading -->
<h2 class="wp-block-heading"><strong>Örnek Kullanım:</strong></h2>
<!-- /wp:heading -->

<!-- wp:preformatted -->
<pre class="wp-block-preformatted"><strong>ÖRNEK                                 AÇIKLAMA</strong>
<strong>tcpdump -r outfile.pcap</strong>              outfile.pcap dosyasındaki tüm paketleri görüntüler
<strong>tcpdump -i any ip and not tcp port 80</strong> Tüm ağ arabirimlerindeki TCP portu 80 olmayan paketleri dinler
<strong>tcpdump -i eth0 -n &gt;32 -w pv01.pcap</strong>  eth0 ağ arabiriminde DNS çözümlemesi olmadan 32 bayttan uzun paketleri yakalar ve pv01.pcap dosyasına kaydeder
<strong>tcpdump -AtuvX icmp</strong>   ICMP trafiğini yakalar ve ICMP paketlerini onaltılık ve ASCII formatında görüntüler
<strong>tcpdump 'tcp port 80 and (((ip[2:2] - ((ip[0]&amp;0xf)&lt;&lt;2)) - ((tcp[12]&amp;0xf0)&gt;&gt;2)) != 0)'</strong>  IPv4 HTTP paketlerini, yani sadece veri içeren paketleri (örneğin SYN ve FIN paketlerini ve yalnızca ACK paketlerini değil) filtreleyerek görüntüler
</pre>
<!-- /wp:preformatted -->

<!-- wp:paragraph -->
<p><strong>Umarım faydalı olmuştur. – Saygılarımla.</strong></p>
<!-- /wp:paragraph -->
