[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/eZm3ZHfi)
# backup-restore-script

-- WRITE HERE --

Backup and Restore Script Project

This project is for the CC373 Operating Systems lab. It contains a shell script to automatically back up a directory and a second script to restore it from different versions. There is also a Makefile to help run the scripts easily.

Project Files

Here's a list of the files in this project and what they do.

Source/: This is the folder you should put your files into.
backup/: The scripts will save all the backups in this folder.
backupd.sh: This script watches the Source folder and creates backups when files change.
restore.sh: This script lets you restore the Source folder to a previous backup version.
backup-cron.sh: This is for the bonus part, to set up an automatic backup schedule.
Makefile: Contains shortcuts to run the backup and restore scripts.
README.md: This file, which explains the project.

Prerequisites

You don't need to install any special software. As long as you are using a Linux system like Ubuntu, you should have everything you need already (bash, make).

How to Use

Here are the steps to run the backup and restore solution.

Step 1: Set up the Source Directory

First, you need to create a folder named Source in the main project directory. Place any files you want to back up inside this folder. The backup directory will be created for you when you run the script.

Step 2: Run the Backup Script

To start backing up your files, open a terminal and run this command:
Bash

make backup

This will start the backupd.sh script. It will make one backup immediately. Then, it will keep checking for any changes in the Source folder every few seconds. If it finds a change, it will create a new backup. The script also cleans up old backups, so it only keeps the most recent ones as defined in the Makefile. To stop the script, press Ctrl+C.

Step 3: Run the Restore Script

If you need to restore your Source folder from a backup, run this command:
Bash

make restore

This starts an interactive script that lets you navigate through your backups. You will see a menu with these options:

    Enter 1: Restore the source directory to the previous version.

Enter 2: Move forward and restore the source directory to the next available version.

Enter 3: Exit the script.

The script will print messages telling you which version was restored.

Bonus: Cron Job for Automatic Backups

The lab also included a bonus part to automate the backup process using a cron job. A cron job is a feature in Linux that runs commands on a schedule.

How to Configure the Cron Job

    Open the crontab file in your terminal. This is where cron jobs are configured.
    Bash

crontab -e

Add the following line to the end of the file. You must replace /path/to/your/project with the full, absolute path to this project's folder on your computer.
Code snippet

    * * * * * /path/to/your/project/backup-cron.sh

    This line tells cron to run the backup-cron.sh script every minute.

    Save and exit the editor. The backup script will now run automatically.

Cron Expression Question

The lab asked for the cron expression needed to run a backup every 3rd Friday of the month at 12:31 am.

The correct expression is:
31 0 15-21 * 5

Here is what each part means:

    31: At minute 31.

    0: At hour 0 (12:00 AM).

    15-21: On a day of the month between the 15th and 21st.

    *: In any month.

    5: On the 5th day of the week (Friday).
