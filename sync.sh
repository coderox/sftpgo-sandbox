#!/bin/bash

LOCAL_DOWNLOAD_DIR="/home/johan/tmp/sftp_download/"

# Remote SFTP server details
REMOTE_SFTP_USER="coderox"
REMOTE_SFTP_HOST="localhost"
REMOTE_SFTP_DIR="/"

# Local SFTP server details
LOCAL_SFTP_USER="programmeramera"
LOCAL_SFTP_HOST="localhost"
LOCAL_SFTP_DIR="/"

download_files() {
# Download files from the remote SFTP server
sftp -i $1 -oPort=2022 "$REMOTE_SFTP_USER@$REMOTE_SFTP_HOST" <<EOF
	cd $REMOTE_SFTP_DIR
	lcd $LOCAL_DOWNLOAD_DIR
	mget *
	bye
EOF
}

upload_files() {
# Upload files to the local SFTP server
sftp -i $1 -oPort=2022 "$LOCAL_SFTP_USER@$LOCAL_SFTP_HOST" <<EOF
	cd $LOCAL_SFTP_DIR
	lcd $LOCAL_DOWNLOAD_DIR
	mput *
	bye
EOF
}

announce_alive() {
	# Announce job is still alive
	echo "Announcing alive..."
    # curl TBC
}

echo "Semaphore..."
if [ ! -d "$LOCAL_DOWNLOAD_DIR" ]; 
then
    # Ensure the local download directory exists
    mkdir -p "$LOCAL_DOWNLOAD_DIR"

	announce_alive

	echo "Fetching keys..."
	REMOTE_KEY="/home/johan/github.com/coderox/sftpgo-sandbox/$REMOTE_SFTP_USER.se.key"
	LOCAL_KEY="/home/johan/github.com/coderox/sftpgo-sandbox/$LOCAL_SFTP_USER.se.key"

    echo "Starting SFTP file transfer..."

    download_files $REMOTE_KEY
    echo "Download complete."

	upload_files $LOCAL_KEY
    echo "Upload complete."

    # Clean up downloaded files
    rm -rf "$LOCAL_DOWNLOAD_DIR"
    echo "Cleanup completed."

    echo "Transfer process finished."
else
    echo "Transfer process cancelled due to existing job ongoing."
fi

exit 0
