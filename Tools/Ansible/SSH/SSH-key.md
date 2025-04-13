# Create SSH Key
```
ssh-keygen -t ed25519 -C "ansible.key"
```
# Fix SSH Key Permissions
```
chmod 600 ~/.ssh/ansible.key
```

# Copy SSH Key
```
ssh-copy-id -i ~/.ssh/ansible.key 192.168.200.50
```
# Test SSH Key
```
ansible all -m ping --key-file ~/.ssh/ansible.key
```
