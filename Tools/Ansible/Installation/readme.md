# Ansible Install On Debian/RHELL:

# Update Repos
```
sudo apt update
```
# Install Ansible
```
> RHELL:
sudo yum install -y epel-release
sudo yum install -y ansible

> Debian:
sudo apt search ansible
sudo apt install software-properties-common
sudo apt install ansible-core
#sudo apt install ansible
#apt-get install sshpass
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
