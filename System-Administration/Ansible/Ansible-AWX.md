# Ansible AWX Cycle Tool
Ansible is an open-source configuration management and automation tool that allows users to manage and deploy software applications and infrastructure at scale. It was created by Michael DeHaan in 2012 and is now maintained by Red Hat.

## Ansible Hosts
The hosts file typically contains the IP addresses or hostnames of the remote machines, along with some configuration information, such as the username and password required for authentication. Ansible uses the information in the hosts file to connect to the remote machines, run commands, and apply configurations.

- Below you can check a basic way to set the localhost into the Ansible hosts file
```bash
[local]
#ensure you have your own machine to manage with Ansible
127.0.0.1 ansible_connection=local
```

- Below you can check a basic way to set your `homelab` into the file:
```bash
[devops-lab]
192.168.1.110 ansible_ssh_user=devopslab ansible_password=password
```

- Below you can check a basic way to set your AWS EC2 instances into the file:
```
[aws]
target1 ansible_ssh_user=ubuntu ansible_ssh_host=18.213.245.111  ansible_ssh_private_key_file=aws-key
```

Please feel free to ge the Ansible Hosts file [here](https://github.com/ansible/ansible/blob/devel/examples/hosts.yaml).

## Ad-hoc Basics
In Ansible, an ad-hoc command is a one-time, on-demand command that you can run on one or more remote hosts without having to write a playbook. It allows you to perform quick, simple tasks such as checking the uptime of a host, installing a package, or copying a file, without the need for a full-blown playbook.

```
ansible [all_servers] -m ping - Verifica se todos os servidores estão funcionando
ansible [all_servers] -a hostname - Printa todos os hostnames dos servidores
ansible [all_servers] -a uptime - Confere a quanto tempo os servers estão em pé
ansible [server] -a free - Verifica o espaço em disco do servidor
ansible [all_servers] -f 1 -a "free" - Roda um comando um servidor por vez
ansible prod -b -m shell -a "df -h /var" -i inventory.yml - executa o comando df -h no host remoto
ansible prod -b -m shell -a "find /var -mount -size +100M -exec du -sh {} \;" -i inventory.yml - executa o comando find no host remoto
ansible prod -b -m shell -a "rm -rf /var/cache/yum/" -i inventory.yml - remove o cche do yum no host remoto
ansible prod -b -m shell -a "ls -l /var/log/audit | tail -n 15" -i inventory.yml - executa o comando de listar arquivos no host remoto
```

### Ad-hoc File Transfer
```
ansible [server] -m copy -a "src=/etc/hosts dest=/tmp/hosts" - Copia o arquivo para outro servidor desejado
ansible [server] -m file -a "dest=/srv/foo/a.txt mode=600" - Para mudar as permissões de um arquivo no servidor remoto
ansible [server] -m file -a "dest=/srv/foo/b.txt mode=600 owner=example group=example" - Para mudar as permissões e o dono/grupo de um arquivo no servidor remoto
ansible [server] -m file -a "dest=/path/to/c mode=755 owner=example group=example state=directory" - Cria um diretório no servidor remoto
ansible [server] -m file -a "dest=/path/to/c state=absent" - Para desinstalar um pacote no servidor remoto
```

### Ad-hoc Manage services
```
ansible [server] -m service -a "name=httpd state=started" - Inicia o service desejado.
ansible [server] -m service -a "name=httpd state=restarted" - Restarta o service desejado.
ansible [server] -m service -a "name=httpd state=stopped" - Pausa o service desejado.
```

### Ad-hoc Manage packages
```
ansible [server] -m apt -a "name=giropops state=present" - Instala o pacote desejado no servidor
ansible [server] -m apt -a "name=giropops-1.2 state=present" - Instala o pacote com a versão desejada
ansible [server] -m apt -a "name=giropops state=latest" - Instala a última versão do pacote desejado
ansible [server] -m apt -a "name=giropops state=absent" - Desinstala o pacote desejado no servidor
```

### Ad-hoc Rebooting servers
```
ansible atlanta -a "/sbin/reboot" - To reboot all the servers in the [atlanta] group
ansible atlanta -a "/sbin/reboot" -f 10 - To reboot the [atlanta] servers with 10 parallel forks:
ansible atlanta -a "/sbin/reboot" -f 10 -u username - To connect as a different user
```

### Ad-hoc Create user and groups
```
ansible [server] -s -m group -a "name=admin state=present" - Cria um grupo no servidor remoto
ansible [server] -s -m user -a "name=giropops group=admin createhome=yes" - Cria um usuário do grupo no servidor remoto
ansible [server] -m user -a "name=giropops password=strigus" - Cria um usuário com senha no servidor remoto
ansible [server] -a "id giropops" - Confirma a criação no servidor
ansible [server] -s -m user -a "name=giropops state=absent" - Deleta um usuário no servidor remoto
```

## Ansible Playbooks

### Ansible playbooks Verifying playbooks
```
ansible-playbook playbook.yml --list-hosts - lista todos os hosts afetados nesse playbook
ansible-playbook playbook.yml --check - executa o playbook em modo de check sem dar apply 
ansible-playbook playbook.yml --list-tasks - lista as tarefas do playbook
ansible-playbook playbook.yml --syntax-check - executa uma verifcacao da sintaxe do YML para do playbook
ansible-playbook --tags=cps playbooks/systems/priority.yml -i inventory.yml
```
```sh
### Installation Guide

Installation Guide
	https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#latest-releases-via-apt-ubuntu



nano /etc/ansible/ansible.cfg

nano /etc/ansible/hosts.cfg    ##need to setup ssh keys for each host, localhost below will not use ssh connection
	[localcomputer]
	localhost ansilbe_connection=local
	[webservers]
	192.168.2.10
	192.168.2.11
	[dnsservers]
	192.168.2.12

ansible all -m shell -a "uname"
ansible webservers -m shell -a "uname"
ansible all -m shell -a "cat /etc/passwd"
ansible webservers -m apt -a "update_cache=yes"      ##will probably not work because of privileges, need to escalate
ansible webservers -m apt -a "update_cache=yes" --become    ##sudo apt update
ansible webservers -m apt -a "upgrade=yes" --become    ##sudo apt upgrade
ansible webservers -m apt -a "name=nginx state=latest" --become    ## -a for argument
ansible webservers -m apt_repository -a "repo=ppa:neovim-ppa/stable state=present" --become    ##add repository

ansible all -m alternatives -a "name=vi path=/usr/bin/nvim priority=60". --become      ##causes vi command to run nvim
ansible all -m group -a "name=admin state=present"    ## create new group
ansible all -m user -a "name=matthew shell=/bin/bash groups=admin append=yes" --become      ## create new user
ansible dbservers -m apt_key -a "keyserver=hkp://keyserver.ubuntu.com:80 id=0C49F3730359A14518585931BC711F9BA15703C6 state=present" --become
ansible dbservers -m apt_repostory -a "repo='deb http://rep.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse' state=present" --become

ansible dbservers -m app -a "name=mondodb-org state=present" --become
ansible dbservers -m service -a "name=mongod state=start" --become
ansible dbservers -m service -a "name=mongod state=stopped" --become
ansible dbservers -m service -a "name=mongod state=restarted" --become
ansible dbservers -m service -a "name=mongod state=reloaded" --become
ansible dbservers -m service -a "name=mongod enabled=yes" --become
ansible dbservers -m service -a "name=mongod enabled=no" --become

ansible webservers -m shell -a "du -h"    ##run shell command
ansible webservers -m command -a "du -h"    ##runs like shell command but will sanitize redirects and pipes

#Handlers
Talks that run if a dependent task runs, Called by notify

#PLAYBOOK (starts with ---, save as a yaml file)
ansible-playbook filename.yaml    ##Call a playbook
ansible-playbook --syntax-check filename.yaml    ##Check a playbook for errors
Ansilbe-playbook filename.yaml --extra-vars "home=/home/vagrant pictures_folder=/home/vagrant/pix"

##add variables through CLI

--------------------------------------

#Setting up the application
- hosts: local
    become: yes
    remote_user: matthew
    tasks:
        - name: "install nginx"

- hosts: webservers
    become: yes
    vars:
        pictures_folder: "/home/vargrant/pix"
    vars_files:
        - ./variables.yaml    #brings in variables from file
    vars_prompt:
        - name: "username"
            prompt: "Enter the username"
            private: no
        - name: "password"
            prompt: "Enter the password"
            private: yes
 handlers:
        - name: "restart the nginx server"
            service:
                  name: nginx
                  state: restart 
        - name: "restart the apache2 server"
            service:
                  name: apache2
                  state: restart 
 tasks:
        - name: "install nginx"
            apt:
                name: nginx
                state: present
        - name: "start nginx"
            service:
                name: nginx
                state: started
            notify:
                  - "restart the nginx server"    #must be same name as handler, will only run if "start nginx" task runs
        - name "create a file in home directory"
            file:
                path:    "{{ home }}/awesome.txt. #uses home variable from above
                state: touch
        - name: "create the picture folder"
            file:
                path: "{{ pictures_folder }}" #used variable for path
                state: directory

- hosts: dbservers
    become: yes
    gathering_facts: no    #speeds things up, but does not display results

- hosts: devmachines
    become: true
    tasks:
        - name: "install git"
            apt: 
                name: git
                state: present
        - name: "install vim"
            apt: 
                name: vim
                state: present
        - name: "setup code folder"
            file: 
                path: /code
                state: directory
        - name: "add developers group"
            group: 
                name: developers
                state: present
----------------------------------------------------------

--- #File named variables.yaml for variables

home: "/home/vagrant"
matt_home_dir: "/home/matthew"

---------------------------------------------------------


---------------------------------------------------------



```
