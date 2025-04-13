# Create SSH Key
```
ssh-keygen -t ed25519 -f /root/.ssh/ansible.key
```
# Fix SSH Key Permissions
```
chmod 600 ~/.ssh/ansible.key
```

# Copy SSH Key
```
ssh-copy-id -i ~/.ssh/ansible.key.pub 192.168.44.145
```
# Test SSH Key
```
ansible all -m ping --key-file ~/.ssh/ansible.key.pub
```
