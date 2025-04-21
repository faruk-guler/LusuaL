# Ansible Install On Debian/RHELL:

# Update Repos
```
sudo apt update
sudo yum update
```
# Install Ansible
```
> RHELL:
sudo yum install -y epel-release
sudo yum install -y ansible

> Debian:
sudo apt install software-properties-common
sudo apt search ansible
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
/etc/ansible/hosts
/etc/ansible/ansible.cfg
cd /etc/ansible/playbooks
cd /etc/ansible/roles
```
# Conf. Check
```
ansible-inventory --graph
ansible all -m ping
```
# #Uninstall Ansible On Debian/RHELL:
```
sudo yum remove ansible [other similar commands]
#sudo apt remove ansible
#sudo apt remove ansible-core
#sudo apt remove sshpass
#sudo apt autoremove
#sudo apt clean

#sudo rm -rf /etc/ansible
#sudo rm -rf ~/.ansible
```
