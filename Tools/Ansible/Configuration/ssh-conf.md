# (SSH authorized_keys) -farukguler.com

# Create SSH Key
```
ssh-keygen -t ed25519 -f /root/.ssh/ansible.key
```
# SSH Key Perm.
```
chmod 600 ~/.ssh/ansible.key
```
# Copy SSH Key to Hosts
```
ssh-copy-id -i /root/.ssh/ansible.key.pub root@192.168.44.145
ssh-copy-id -i /root/.ssh/ansible.key.pub root@192.168.44.146
ssh-copy-id -i /root/.ssh/ansible.key.pub root@192.168.44.147
```
# Test SSH Key
```
ssh -i /root/.ssh/ansible.key root@192.168.44.145
ansible all -m ping --key-file ~/.ssh/ansible.key
```
