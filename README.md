# Prepare RedHat Demo Platform

The playbooks in this repository prepare the RedHat Demo Lab Environment for the **Ansible Linux Automation Workshop**.  
They create the desired directory structure and deploys all files and playbooks, which are done in the Lab exercises.

> The content is intended to run *inside* the Workshop environment!

## 🔌 Requirements & Usage

1. Start the **Visual Studio Code** instance and open a **Terminal**. Ensure that you are in the *home directory*.

2. Clone the repository into the home folder:

    ```console
    git clone https://github.com/TimGrt/prepare-redhat-demo-system
    ```

3. Run the playbook `prepare_execution.yml` to install all necessary dependencies:

    ```console
    ansible-playbook prepare_execution.yml
    ```

> All content will only be deployed *as is*, but not executed. The AAP content (e.g. Projects, Job-Templates, ...) will be configured, but not executed as well.

### 🌱 Ansible Basics Exercises

The following playbook creates all files and folder from the [Ansible Basics exercises](https://timgrt.github.io/Ansible-Workshop-Exercises/ansible-basics-overview/):

```console
ansible-playbook create_ansible_basics_exercises.yml
```

### 🌳 Automation Platform exercises

The following playbook creates all files and folder from the [Automation platform exercises](https://timgrt.github.io/Ansible-Workshop-Exercises/automation-platform-overview/):

```console
ansible-playbook create_automation_platform_exercises.yml
```

### 🌿 Projects exercises

The following playbook creates **all** files and folder from the [Project exercises](https://timgrt.github.io/Ansible-Workshop-Exercises/projects/projects-overview/):

```console
ansible-playbook create_projects_exercises.yml
```

Run playbook with `--list-tags` to show available tags. You can deploy only specific projects content if desired, for example:

```console
ansible-playbook create_projects_exercises.yml -t network
```

## 💊 Fix SSH connection from bonus exerxise

The *bonus* exercises [Ansible Basics - Bonus Lab 1 - Prepare Infrastructure](https://timgrt.github.io/Ansible-Workshop-Exercises/ansible-core/ansible-core-supplemental/#bonus-lab-1-prepare-infrastructure) is intended to break the initially working SSH connection to all managed nodes (you will end up as the *ec2-user* on all nodes, configured by `~/.ssh/config`). This is no "Real World" setup and is adjusted during the exercise.

To break the initially working SSH connection (this is done as part of the exercise), download the script and execute it:

```console
[student1@ansible-1 ~]$ wget -q https://raw.githubusercontent.com/TimGrt/prepare-redhat-demo-system/master/break-ssh.sh
[student1@ansible-1 ~]$ sh break-ssh.sh
```

To "fix" the SSH connection, use the following playbook. It creates a service user on all hosts after breaking the SSH connection with the previous script. You have to provide the Workshop password, this is used as the SSH password to all nodes:

```console
[student1@ansible-1]$ ansible-playbook fix-ssh.yml --ask-pass
```
