# Prepare RedHat Demo System

This playbook prepares the RedHat Demo Lab Environment for the _Ansible Linux Automation Workshop_.
It creates the desired directory structure and deploys all files and playbooks, which are done in the Lab exercises.

See [RedHat Workshop Github Page](https://ansible.github.io/workshops/exercises/ansible_rhel/) for all lab exercises.

Clone the repository into the home folder:
```
[student1@ansible-1]$ git clone http://gitlab.ccloud.ninja/tgruetzmacher/prepare-redhat-demo-system.git
```

Run the playbook:
```
[student1@ansible-1]$ ansible-playbook prepare.yml
```

