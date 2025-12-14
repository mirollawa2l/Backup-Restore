# Backup and Restore Script Project

This project provides a simple backup and restore solution implemented using Bash scripts. It provides a simple backup and restore solution using Bash scripts, along with a Makefile to simplify execution. The system automatically creates versioned backups of a directory and allows restoring previous versions interactively.

---

## Project Structure

```
.
├── Source/            # Directory to be backed up (user files go here)
├── backup/            # Automatically created folder that stores backups
├── backupd.sh         # Monitors Source/ and creates backups on changes
├── restore.sh         # Restores Source/ from selected backup versions
├── backup-cron.sh     # Bonus: script used with cron for scheduled backups
├── Makefile           # Provides easy commands to run scripts
└── README.md          # Project documentation
```

---

## Prerequisites

No additional software installation is required. The project runs on any Linux distribution (e.g., Ubuntu) with:

* `bash`
* `make`
* Standard GNU utilities

---

## How to Use

### Step 1: Set Up the Source Directory

Create a directory named `Source` in the main project folder:

```bash
mkdir Source
```

Place any files or folders you want to back up inside `Source/`. The `backup/` directory will be created automatically when the backup script runs.

---

### Step 2: Run the Backup Script

Start the backup daemon using:

```bash
make backup
```

**What this does:**

* Creates an initial backup immediately
* Periodically checks the `Source/` directory for changes
* Creates a new backup whenever a change is detected
* Automatically deletes older backups, keeping only the most recent versions (as defined in the Makefile)

To stop the backup process, press **Ctrl + C**.

---

### Step 3: Run the Restore Script

To restore files from a previous backup version, run:

```bash
make restore
```

This launches an interactive menu with the following options:

* **1** – Restore the previous backup version
* **2** – Restore the next available backup version
* **3** – Exit the restore script

The script prints informative messages indicating which backup version is currently restored.

---

## Bonus: Automatic Backups Using Cron

As part of the bonus requirement, backups can be automated using a **cron job**, which allows scripts to run on a fixed schedule.

### How to Configure the Cron Job

1. Open the crontab editor:

```bash
crontab -e
```

2. Add the following line at the end of the file (replace `/path/to/your/project` with the absolute path to this project):

```bash
* * * * * /path/to/your/project/backup-cron.sh
```

3. Save and exit the editor.

This configuration runs the backup script **every minute**.

---

## Cron Expression Question

**Question:** What cron expression runs a backup every **3rd Friday of the month at 12:31 AM**?

**Answer:**

```
31 0 15-21 * 5
```

### Explanation

| Field        | Value   | Meaning                   |
| ------------ | ------- | ------------------------- |
| Minute       | `31`    | At minute 31              |
| Hour         | `0`     | At 12:00 AM               |
| Day of Month | `15-21` | Between the 15th and 21st |
| Month        | `*`     | Every month               |
| Day of Week  | `5`     | Friday                    |

This works because the **3rd Friday** of any month always falls between the 15th and 21st.

---

## Notes

* Ensure scripts have execute permission:

```bash
chmod +x *.sh
```

* This project demonstrates key OS concepts such as process automation, file system monitoring, and scheduling using cron.

---

This project demonstrates automated backups, version control of directories, interactive restoration, and optional scheduled execution using cron.

