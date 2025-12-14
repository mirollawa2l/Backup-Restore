#! /bin/bash

######################
# YOUR CODE HERE VVVVV

if [ "$#" -ne 2 ]
then
  echo "Usage: $0 <source_dir> <backup_dir>"
  exit 1
fi

dir="$1"
backupdir="$2"
if [ ! -d "$backupdir" ]; then
  echo "Backup directory does not exist"
fi

if [ ! -d "$dir" ]; then
  echo "Source directory does not exist"
  exit 1
fi


if [ "$dir" = "$backupdir" ]; then
  echo "Source and Backup can't be the same"
  exit 1
fi


mkdir -p "$backupdir/.hidden"


mapfile -t backups < <(ls -1 "$backupdir" | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}-[0-9]{2}$' | sort)

if [ "${#backups[@]}" -eq 0 ]
then
  echo "No backups in $backupdir try again"
  exit 1
fi

currentIndex=-1
for i in "${!backups[@]}"
do
  backupTimestamp="${backups[$i]}"
  backupPath="$backupdir/$backupTimestamp"
  if diff -qr "$dir" "$backupPath" &>/dev/null
  then
    currentIndex=$i
    break
  fi
done

if [ "$currentIndex" -eq -1 ]
then
  echo "No matching backup found for current state"
  exit 1
fi

while true
do
  echo ""
  echo "1: Restore previous version"
  echo "2: Restore next version"
  echo "3: Exit"
  read -rp "Choose an option: " ans

  if [[ "$ans" -eq 1 ]]
  then
    if [ "$currentIndex" -le 0 ]
    then
      echo "No older backup available to restore."
      continue   
    else
      prevIndex=$((currentIndex - 1))
      prevTimestamp="${backups[$prevIndex]}"
      rm -rf "$dir"/*
      cp -r "$backupdir/$prevTimestamp"/. "$dir"/
      currentTimestamp="$prevTimestamp"
      currentIndex=$prevIndex
      echo "Restored to a previous version : $prevTimestamp"
    fi

  elif [[ "$ans" -eq 2 ]]
  then
    if (( currentIndex >= ${#backups[@]} - 1 ))
    then
      echo "No newer backup available to restore."
      continue   
    else
      nextIndex=$((currentIndex + 1))
      nextTimestamp="${backups[$nextIndex]}"
      rm -rf "$dir"/*
      cp -r "$backupdir/$nextTimestamp"/. "$dir"/
      currentTimestamp="$nextTimestamp"
      currentIndex=$nextIndex
      echo "Restored to a next version : $nextTimestamp"
    fi

  elif [[ "$ans" -eq 3 ]]
  then
    echo "Exiting....."
    exit 0
  else
    echo "Invalid choice Try again"
  fi
done

######################
######################

