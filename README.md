# Prepare RedHat Demo System

This playbook prepares the RedHat Demo Lab Environment for the _Ansible Linux Automation Workshop_.
It creates the desired directory structure and deploys all files and playbooks, which are done in the Lab exercises.

See [RedHat Workshop Github Page](https://ansible.github.io/workshops/exercises/ansible_rhel/) for all lab exercises.

Clone the repository into the home folder:
```bash
[student1@ansible-1]$ git clone http://gitlab.ccloud.ninja/tgruetzmacher/prepare-redhat-demo-system.git
```

Run the playbook:
```bash
[student1@ansible-1]$ ansible-playbook prepare.yml
```

To break the initially working SSH connection for all attendees, download the script and execute it:
```bash
[student1@ansible-1 ~]$ wget -q https://raw.githubusercontent.com/TimGrt/prepare-redhat-demo-system/master/prepare-attendee.sh
[student1@ansible-1 ~]$ sh prepare-attendee.sh 
```

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
