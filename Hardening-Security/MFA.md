# Multi-Factor Authentication MFA Google



>File: sudo nano /etc/ssh/sshd_config
```bash
AuthenticationMethods publickey,keyboard-interactive
AuthenticationMethods publickey,keyboard-interactive:pam
AuthenticationMethods publickey,keyboard-interactive
```

