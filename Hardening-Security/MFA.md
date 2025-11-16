# Multi-Factor Authentication MFA Google
Setting up and using multi-factor authentication (MFA) on your Linux servers is a highly effective security measure, especially for protecting SSH access. The most common and reliable method for setting up multi-factor authentication (MFA) is to use the Google Authenticator PAM module.



>File: sudo nano /etc/ssh/sshd_config
```bash
AuthenticationMethods publickey,keyboard-interactive
AuthenticationMethods publickey,keyboard-interactive:pam
AuthenticationMethods publickey,keyboard-interactive
```

