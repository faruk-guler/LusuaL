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
```
# Check Version
```
ansible --version
```
# Ansible Conf.
```
cd /etc/ansible/hosts
cd /etc/ansible/ansible.cfg
cd /etc/ansible/playbooks
```
# Check Conf.
```
ansible-inventory --graph
```
