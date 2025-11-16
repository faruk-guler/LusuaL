# Multi-Factor Authentication MFA Google
Setting up and using multi-factor authentication (MFA) on your Linux servers is a highly effective security measure, especially for protecting SSH access. The most common and reliable method for setting up multi-factor authentication (MFA) is to use the Google Authenticator PAM module.

# Google Authenticator PAM Kurulumu:
```bash
sudo apt update
sudo apt install libpam-google-authenticator -y
```
# Kullanıcı İçin MFA Yapılandırması:
```bash
google-authenticator
```
```bash
1: "Do you want authentication tokens to be time-based?" (y)
2: QR Code
3: "Do you want me to update your ~/.google_authenticator file?" (y)
4: "Do you want to disallow multiple uses of the same authentication token?" (y)
5: "By default, tokens are good for 30 seconds..." (n)
6: "Do you want to enable rate-limiting?" (y)
```
# SSH için PAM Yapılandırması:
>File: sudo nano /etc/pam.d/sshd
```bash
sudo nano /etc/pam.d/sshd
```

Dosyanın **en üstüne** şu satırı ekleyin:
```
auth required pam_google_authenticator.so
```

Ayrıca, yalnızca şifre ile girişi engellemek için şu satırı bulup yorum satırı yapın (başına # ekleyin):
```
# @include common-auth
```

# SSH Daemon Yapılandırması:
>File: sudo nano /etc/ssh/sshd_config
```bash
AuthenticationMethods publickey,keyboard-interactive
AuthenticationMethods publickey,keyboard-interactive:pam
AuthenticationMethods publickey,keyboard-interactive
```
# Sudo için MFA (Opsiyonel)
>File: sudo nano /etc/pam.d/sudo
```bash
auth required pam_google_authenticator.so
```

# SSH Service:
```bash
sudo systemctl restart ssh
sudo systemctl restart sshd
```
# Backup:
> All suer ~/.google_authenticator file backup
```bash
cp ~/.google_authenticator ~/.google_authenticator.backup
```bash
