#!/bin/bash

######################
# YOUR CODE HERE VVVVV
if [ "$#" -eq 4 ]
then
  dir="$1"
  backupdir="$2"
  t="$3"
  n="$4"
elif [ "$#" -eq 0 ]
then
  read -rp "Enter source directory:  " dir
  dir=$(eval echo "$dir")
  #echo "$dir"
  read -rp "Enter backup directory:  " backupdir
  backupdir=$(eval echo "$backupdir")

  read -rp "Enter time to wait between every check:  " t
  #echo "$t"
  read -rp "Enter maximum number of backups to be reserved:  " n
  #echo "$n"
elif [ "$#" -ne 4 ]
then
  echo "Number of arguments isn't 4"
  exit 1
fi


if [ -d "$dir" ]
then 
  :
else 
  echo "Source directory doesn't exist"
  exit 1
fi

if [ -d "$backupdir" ]
then 
  if [ "$dir" = "$backupdir" ]
  then
    echo "You can't Backup to the same directory"
    exit 1
  fi
else 
  echo "Backup directory doesn't exist"
  exit 1
fi

if [[ ! "$t" =~ ^[0-9]+$ ]]
then
  echo "Time is not a number please Retry"
  exit 1
fi

if [[ ! "$n" =~ ^[0-9]+$ ]]
then  
  echo "Number entered is not a number please Retry"
  exit 1
fi

hiddenDir="$backupdir/.hidden"
mkdir -p "$hiddenDir"
infoLast="$hiddenDir/directory-info.last"
infoNew="$hiddenDir/directory-info.new"

rm -rf "$infoLast" "$infoNew"

count=0
#cp -rT "$dir" "$hiddenDir/directory-info.last"  #copy even if empty

timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
ls -lR "$dir" > "$infoLast"
mkdir -p "$backupdir/$timestamp"   #-p for parent
cp -rT "$dir"  "$backupdir/$timestamp"
count=$(( count+1 ))
echo "Initial Backup completed"
while true
do
  sleep "$t"
  ls -lR "$dir" > "$infoNew"
  if ! cmp -s "$infoLast" "$infoNew"  
  then
    timestamp=$(date +"%Y-%m-%d-%H-%M-%S")
    mkdir -p "$backupdir/$timestamp"   #-p for parent
    cp -rT "$dir"  "$backupdir/$timestamp"
    echo "Backup Completed"
    mv "$infoNew" "$infoLast"
    count=$((count+1)) #(( to evaluate as math expr
    
    num_backups=$(ls -1 "$backupdir" | wc -l)
    if [ "$num_backups" -gt "$n" ]
    then
      ls -1t "$backupdir" | grep -v "^\.hidden$" | tail -n +$((n + 1)) | while read old_backup; do
        rm -rf "$backupdir/$old_backup"
      done
    fi

  fi
done


######################
