sudo apt update -y && sudo apt upgrade -y

sudo apt install ansible sshpass -y

sudo nano /etc/ansible/hosts

![Screenshot from 2024-05-14 16-29-55](https://github.com/buusratekiin/ansible_playbook/assets/88576734/fecce075-0b54-4454-b00b-a9b57c46d612)

ansible-inventory --list -y

![Screenshot from 2024-05-14 16-32-00](https://github.com/buusratekiin/ansible_playbook/assets/88576734/c8611c24-8516-4fe4-ac30-62da8b37bdd4)


sudo nano /etc/ansible/ansible.cfg

![Screenshot from 2024-05-14 16-33-10](https://github.com/buusratekiin/ansible_playbook/assets/88576734/26882a65-ab5f-4246-9e09-206a85dbdf23)

Ping Test:

ansible all -m ping -u sysadmin --ask-pass

![Screenshot from 2024-05-14 16-34-43](https://github.com/buusratekiin/ansible_playbook/assets/88576734/854b53ce-c21d-4aac-81f2-7286b2c8095b)

Run Command Playbooks:

ansible-playbook -i /etc/ansible/hosts ymlname.yml --ask-pass --ask-become-pass
