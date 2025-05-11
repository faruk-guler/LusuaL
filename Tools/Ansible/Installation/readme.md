# Ansible Install On Debian/RHELL:

# Update Repos
```
sudo apt update
sudo yum update
```
# Install Ansible
```
> RHELL:
sudo yum install epel-release -y 
sudo yum install ansible -y 

> Debian:
sudo apt install software-properties-common
sudo apt install ansible-core
#sudo apt install ansible
#sudo apt install sshpass

> macOS:
brew install ansible

> Python PIP:
pip install ansible
```
# Check Version
```
ansible --version
```
# Ansible Conf.
```
vi /etc/ansible/hosts
vi /etc/ansible/ansible.cfg
cd /etc/ansible/playbooks
cd /etc/ansible/roles
```
# Conf. Check
```
ansible-config dump
ansible-inventory --graph
ansible all -m ping
```
# #Uninstall Ansible On Debian/RHELL:
```
#sudo yum remove ansible [other similar commands]
#sudo apt remove ansible
#sudo apt remove ansible-core
#sudo apt remove sshpass
#sudo apt autoremove
#sudo apt clean

#sudo rm -rf /etc/ansible
#sudo rm -rf ~/.ansible
```
