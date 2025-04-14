# Ansible Install On Debian:

# Update Repos
```
sudo apt update
```
# Install Dependencies
```
sudo apt install software-properties-common
```
# Install Ansible
```
sudo apt search ansible
sudo apt install ansible-core
#sudo apt install ansible
```
# Check Version
```
ansible --version
```
# Ansible Conf.
```
/etc/ansible/hosts.ini
/etc/ansible/ansible.cfg
cd /etc/ansible/playbooks
```
# Check Conf.
```
ansible-inventory --graph
ansible all -m ping
```
