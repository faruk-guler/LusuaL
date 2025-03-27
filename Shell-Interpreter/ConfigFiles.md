
## Shell Yapılandırma Dosyaları

### 1.1 Bash (Bourne-Again Shell)
| Dosya | Kullanım Amacı | Yükleme Zamanı | Sistem Geneli? |
|-------|---------------|----------------|----------------|
| `~/.bashrc` | Interaktif oturum ayarları | Her terminal açılışında | ❌ |
| `~/.bash_profile` | Login shell ayarları | Kullanıcı girişinde | ❌ |
| `~/.bash_logout` | Çıkış komutları | Shell'den çıkışta | ❌ |
| `/etc/bash.bashrc` | Global bash ayarları | Tüm kullanıcılarda | ✔️ |

### 1.2 Zsh (Z Shell)
| Dosya | Kullanım Amacı | Yükleme Zamanı | Sistem Geneli? |
|-------|---------------|----------------|----------------|
| `~/.zshrc` | Interaktif oturum ayarları | Her terminal açılışında | ❌ |
| `~/.zprofile` | Login shell ayarları | Kullanıcı girişinde | ❌ |
| `/etc/zshrc` | Global zsh ayarları | Tüm kullanıcılarda | ✔️ |

### 1.3 Fish (Friendly Interactive Shell)
| Dosya | Kullanım Amacı | Yükleme Zamanı | Sistem Geneli? |
|-------|---------------|----------------|----------------|
| `~/.config/fish/config.fish` | Tüm yapılandırma | Her shell başlangıcında | ❌ |
| `/etc/fish/config.fish` | Global ayarlar | Tüm kullanıcılarda | ✔️ |

### 1.4 **Diğer Shell'ler**
- **sh (Bourne Shell)**: Temel kabuk, betikler için ideal.
- **ksh (Korn Shell)**: Yüksek performanslı betikleme.
- **dash**: Hafif versiyon (`/bin/sh` genellikle dash'e bağlı).


# Linux Shell'leri ve Yapılandırma Rehberi

## 🐚 Popüler Linux Shell'leri

### 1. **Bash (Bourne-Again Shell)**
- **Özellikler**: Linux'un varsayılan kabuğu, `sh` uyumlu, geniş eklenti desteği.
- **Yapılandırma Dosyaları**:
  - `~/.bashrc` (Terminal ayarları)
  - `~/.bash_profile` (Login shell ayarları)
  - `~/.bash_aliases` (Özel kısayollar)

### 2. **Zsh (Z Shell)**
- **Özellikler**: Gelişmiş otomatik tamamlama, tema desteği (Oh My Zsh), macOS'ta varsayılan.
- **Yapılandırma Dosyaları**:
  - `~/.zshrc` (Ana yapılandırma)
  - `~/.zprofile` (Login ayarları)

### 3. **Fish (Friendly Interactive Shell)**
- **Özellikler**: Kullanıcı dostu arayüz, renkli syntax, script uyumluluğu düşük.
- **Yapılandırma Dosyaları**:
  - `~/.config/fish/config.fish`
  - `~/.config/fish/functions/` (Özel fonksiyonlar)

### 4. **Diğer Shell'ler**
- **sh (Bourne Shell)**: Temel kabuk, betikler için ideal.
- **ksh (Korn Shell)**: Yüksek performanslı betikleme.
- **dash**: Hafif versiyon (`/bin/sh` genellikle dash'e bağlı).

---
