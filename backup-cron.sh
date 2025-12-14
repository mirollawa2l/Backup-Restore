#!/bin/bash
# backup-cron.sh

sleep 23;

sourceDir="$HOME/Documents/GitHub/os25f-lab2-mirollawa2l/Source"
backupDir="$HOME/Documents/GitHub/os25f-lab2-mirollawa2l/backup"
maxBackups=10
trackingDir="$backupDir/tracking" 

mkdir -p "$backupDir"
mkdir -p "$trackingDir"

newInfoFile="$trackingDir/directory-info.new"
lastInfoFile="$trackingDir/directory-info.last"
ls -lR "$sourceDir" > "$newInfoFile"

if [ ! -f "$lastInfoFile" ]; then
  echo "No last backup info found. Creating initial backup."
  timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
  cp -r "$sourceDir" "$backupDir/$timestamp"
  cp "$newInfoFile" "$lastInfoFile" # Start the tracking history
  echo "Initial backup created at $backupDir/$timestamp"
  exit 0
fi

if ! cmp -s "$newInfoFile" "$lastInfoFile"; then
  # If different, create a new backup
  timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
  cp -r "$sourceDir" "$backupDir/$timestamp"
  echo "Changes detected. New backup created at $backupDir/$timestamp"
  mv "$newInfoFile" "$lastInfoFile"

  ls -1t "$backupDir" | grep '^[0-9]' | tail -n +$((maxBackups + 1)) | while read -r oldBackup; do
    rm -rf "$backupDir/$oldBackup"
    echo "Removed old backup: $oldBackup"
  done
else
  timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
  echo "No changes detected. No backup needed at $timestamp."
fi

