# Prepare RedHat Demo System

This playbook prepares the RedHat Demo Lab Environment for the _Ansible Linux Automation Workshop_.
It creates the desired directory structure and deploys all files and playbooks, which are done in the Lab exercises.

## Usage

Clone the repository into the home folder:

```bash
[student1@ansible-1]$ git clone http://gitlab.ccloud.ninja/tgruetzmacher/prepare-redhat-demo-system.git
```

Install required collections:

```bash
[student1@ansible-1]$ ansible-galaxy collection install -r requirements.yml
```

To break the initially working SSH connection (this is done as part of an exercise), download the script and execute it:

```bash
[student1@ansible-1 ~]$ wget -q https://raw.githubusercontent.com/TimGrt/prepare-redhat-demo-system/master/break-ssh.sh
[student1@ansible-1 ~]$ sh break-ssh.sh 
```

To "fix" the SSH connection use the following playbook. It creates a service user on all hosts after breaking the SSH connection with the previous script. You have to provide the Workshop password, this is used as the SSH password to all nodes:

```bash
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
