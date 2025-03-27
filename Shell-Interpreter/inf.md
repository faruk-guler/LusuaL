# Linux/Unix Shell (Kabuklar)

## Giriş
Shell, kullanıcı ile işletim sistemi çekirdeği (kernel) arasında köprü kuran komut yorumlayıcısıdır. Bu belge, tüm önemli kabuk türlerini ve özelliklerini kapsar.

---

## 1. Bourne Ailesi Kabuklar

### 1.1 sh (Bourne Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Stephen Bourne (1977)                                                |
| **Öne Çıkanlar** | - Unix'in ilk kabuğu<br>- POSIX standartlarının temeli               |
| **Kullanım**    | Eski sistem betikleri, gömülü cihazlar                               |

### 1.2 bash (Bourne-Again Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Brian Fox (1989)                                                     |
| **Öne Çıkanlar** | - Linux varsayılan kabuğu<br>- Komut geçmişi, diziler, `[[ ]]`       |
| **Kullanım**    | Günlük kullanım, Linux betikleri                                     |

### 1.3 dash (Debian Almquist Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Debian Projesi                                                       |
| **Öne Çıkanlar** | - `/bin/sh` alternatifi<br>- Sistem betikleri için optimize           |
| **Kullanım**    | Debian/Ubuntu başlatma betikleri                                     |

---

## 2. C Ailesi Kabuklar

### 2.1 csh (C Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Bill Joy (1978)                                                      |
| **Öne Çıkanlar** | - C benzeri sözdizimi                                                |
| **Kullanım**    | Tarihsel kullanım                                                    |

### 2.2 tcsh (TENEX C Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Ken Greer                                                            |
| **Öne Çıkanlar** | - csh + komut tamamlama                                              |
| **Kullanım**    | C sözdizimi sevenler                                                 |

---

## 3. Modern Kabuklar

### 3.1 zsh (Z Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Paul Falstad (1990)                                                  |
| **Öne Çıkanlar** | - macOS varsayılan (≥10.15)<br>- Oh-My-Zsh eklentileri               |
| **Kullanım**    | Geliştiriciler, interaktif kullanım                                  |

### 3.2 fish (Friendly Interactive Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Axel Liljencrantz (2005)                                             |
| **Öne Çıkanlar** | - Öğrenmesi kolay<br>- Renkli otomatik tamamlama                     |
| **Kullanım**    | Yeni başlayanlar                                                     |

---

## 4. Diğer Kabuklar

### 4.1 ksh (Korn Shell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | David Korn (1983)                                                    |
| **Öne Çıkanlar** | - Enterprise sistemlerde kullanım<br>- Güçlü betikleme               |
| **Kullanım**    | AIX/Solaris sistemleri                                               |

### 4.2 pwsh (PowerShell)
| Özellik       | Değer                                                                 |
|---------------|-----------------------------------------------------------------------|
| **Geliştirici** | Microsoft                                                            |
| **Öne Çıkanlar** | - Platformlar arası<br>- Obje tabanlı çıktı                          |
| **Kullanım**    | Windows/Linux sistem yönetimi                                        |

---

## Karşılaştırma Tablosu

| Özellik               | bash | zsh  | fish | ksh  | tcsh |
|-----------------------|------|------|------|------|------|
| **Varsayılan (Linux)**| ✔️   | ❌   | ❌   | ❌   | ❌   |
| **Betik Uyumluluğu**  | sh++ | sh+  | ❌   | sh+++| csh  |
| **Otomatik Tamamlama**| ⭐⭐ | ⭐⭐⭐| ⭐⭐⭐⭐| ⭐⭐ | ⭐⭐  |

---

## Kabuk Seçim Kılavuzu

1. **Linux Sistem Yönetimi** → `bash`
2. **Gelişmiş Kullanıcı Arayüzü** → `zsh`
3. **Betik Taşınabilirliği** → `sh`/`ksh`
4. **Yeni Başlayanlar** → `fish`
5. **Windows Entegrasyonu** → `pwsh`

---

## Kabuk Değiştirme

```bash
# Mevcut kabuğu görüntüle
echo $SHELL

# Yeni kabuk yükleme (Örnek: zsh)
sudo apt install zsh  # Debian/Ubuntu
chsh -s $(which zsh)  # Varsayılan yap
