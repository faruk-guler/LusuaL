# What is Ansible? -farukguler.com

<p align="center">
<img src="https://blog.noblinkyblinky.com/wp-content/uploads/2020/05/highres_467012712.png" alt="Ansible Logo" width="300"/>
</p>

Ansible lets you perform configuration management, task automation, security/compliance tasks, orchestration, cloud provisioning, and application deployment easily and in an automated fashion. In simple terms, Ansible follows a master-slave architecture — you have an **Ansible control node**, where you will trigger and manage your jobs (playbooks), and **managed nodes**, the machines you want to run the playbooks on (inventory). Ansible was created by Michael DeHaan in 2012 and is now maintained by Red Hat.

## Key Features

- **Agentless**: Runs over SSH or WinRM (Windows Remote Management), no additional software is installed on managed machines
- **YAML Based**: Playbooks are written in YAML format
- **Idempotent**: Even if the same playbook is run more than once, the final state of the system does not change
- **Modular Structure**: Provides fast automation with ready-to-use modules
- **Platform Independent**: Works with Linux, Windows, macOS, network devices and cloud services

## Ansible Architecture

### Components
- **Control Node**: Host machine where playbooks are run (must be Linux/Unix based)
- **Managed Nodes**: Servers managed with Ansible (Linux, Windows, network devices, etc.)
- **Inventory**: List of managed machines
- **Playbook**: YAML files that define automation tasks
- **Modules**: Predefined tasks (e.g. `apt`, `yum`, `copy`, `file`, `service`, `template`, `.etc`)

## Technical Details
- Ansible only needs **SSH** connectivity to establish connectivity to the managed nodes (uses **WinRM** for Windows)
- Uses **inventory files** to specify the managed nodes
- **Minimal dependencies**: Only requires Python and a few support libraries
- **Declarative language**: Uses YAML for playbooks
- **Idempotent**: Ensures no unintended changes when rerunning playbooks
- **Run once**: Only checks the current status when run and corrects it if necessary. Does not monitor the status in the background like Kubernetes.


