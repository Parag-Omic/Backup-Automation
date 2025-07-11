# 💾 Backup Automation for Network Devices & Linux Servers

This script automates the backup of configuration files from network devices (Cisco/Juniper) or full directories from Linux servers via SSH or rsync. Backups are stored in organized, timestamped folders with optional compression and email notification support.

---

## 🎯 Purpose

- Automate secure, consistent backups of device configurations and critical system files.
- Enable daily or weekly backups to meet compliance, audit, or DR (Disaster Recovery) requirements.

---

## 🔐 Use Case

Used by system and network engineers to back up device configs, server `/etc`, logs, home directories, or databases — automatically and securely.

---

## 📂 Files Used

### `backup_targets.txt`

```text
# Format: <IP> <os-type> <username> <password> <path_to_backup>
192.168.1.10 ubuntu admin password123 /etc
192.168.1.11 centos root pass1234 /home/data
