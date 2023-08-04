# Prepare RedHat Demo System

This playbook prepares the RedHat Demo Lab Environment for the _Ansible Linux Automation Workshop_.
It creates the desired directory structure and deploys all files and playbooks, which are done in the Lab exercises.

## Usage

Clone the repository into the home folder:

```console
git clone https://github.com/TimGrt/prepare-redhat-demo-system
```

Deploy all files and folder, which are created during the workshop, either for every workshop topic or all at once.

```console
ansible-playbook create-ansible-basics-exercises.yml
```

```console
ansible-playbook create-automation-platform-exercises.yml
```

```console
ansible-playbook create-projects-exercises.yml
```

```console
ansible-playbook create-all-exercises.yml
```

The exercises for Automation Platform are executed, all other playbooks are not run, only the files are deployed.

## SSH connection

The *bonus* exercises [Ansible Basics - Bonus Lab 1 - Prepare Infrastructure](https://timgrt.github.io/Ansible-Workshop-Exercises/ansible-core/ansible-core-supplemental/#bonus-lab-1-prepare-infrastructure) is intended to break the initially working SSH connection to all managed nodes (you will end up as the *ec2-user* on all nodes, configured by `~/.ssh/config`). This is no "Real World" setup and is adjusted during the exercise.

Install required collections (`fix-ssh.yml` playbook uses module of *posix* collection):

```console
[student1@ansible-1]$ ansible-galaxy collection install -r requirements.yml
```

To break the initially working SSH connection (this is done as part of the exercise), download the script and execute it:

```console
[student1@ansible-1 ~]$ wget -q https://raw.githubusercontent.com/TimGrt/prepare-redhat-demo-system/master/break-ssh.sh
[student1@ansible-1 ~]$ sh break-ssh.sh
```

To "fix" the SSH connection, use the following playbook. It creates a service user on all hosts after breaking the SSH connection with the previous script. You have to provide the Workshop password, this is used as the SSH password to all nodes:

```console
[student1@ansible-1]$ ansible-playbook fix-ssh.yml --ask-pass
```

## Ansible Navigator

Use the following `.ansible-navigator.yml` instead of the provided one, this uses some useful configurations. Ensure that the used execution environment is still valid.

```yaml
---
ansible-navigator:
  ansible:
# Specify an inventory file path or comma separated host list
    inventories:
    - /home/student1/lab_inventory/hosts
# Sets configuration for  the creation of artifacts for completed playbooks.
# Can be enabled or disabled and specify filename and location
  playbook-artifact:
    enable: true
    save-as: ~/ansible-files/artifacts/{playbook_name}-artifact-{ts_utc}.json
# Set user interface mode, either 'stdout' or 'interactive'
# Mode 'stdout' ensures same output method as with ansible-playbook command
  mode: stdout

# Enable or disable the use of an execution environment and specify different options
  execution-environment:
    image: registry.redhat.io/ansible-automation-platform-20-early-access/ee-supported-rhel8:2.0.0
    enabled: true
    container-engine: podman
    pull-policy: missing
    volume-mounts:
    - src: "/etc/ansible/"
      dest: "/etc/ansible/"
```
