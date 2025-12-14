
SRC_DIR := Source
BACKUP_DIR := backup
INTERVAL := 3
MAX_BACKUPS := 2

all: backup

prepare:
	@mkdir -p $(BACKUP_DIR)
	@echo "Backup directory prepared: $(BACKUP_DIR)"

backup: prepare
	echo "Running backup script..."
	bash backupd.sh $(SRC_DIR) $(BACKUP_DIR) $(INTERVAL) $(MAX_BACKUPS)


backup@: prepare
	@echo "Running backup script..."
	@bash backupd.sh $(SRC_DIR) $(BACKUP_DIR) $(INTERVAL) $(MAX_BACKUPS)

restore:
	@echo "Running restore script..."
	@bash restore.sh $(SRC_DIR) $(BACKUP_DIR)

clean:
	@echo "Removing all backups..."
	@rm -rf $(BACKUP_DIR)/*
	@echo "Backups cleaned."

help:
	@echo "Available commands:"
	@echo "  make backup   - Run the backup script"
	@echo "  make restore  - Run the restore script"
	@echo "  make clean    - Delete all backups"
