#!/bin/bash

# Remote SFTP server details
REMOTE_SFTP_USER="coderox"
REMOTE_SFTP_HOST="localhost"
REMOTE_SFTP_DIR="/"
LOCAL_DOWNLOAD_DIR="/home/johan/tmp/sftp_download/"

# Local SFTP server details
LOCAL_SFTP_USER="programmeramera"
LOCAL_SFTP_HOST="localhost"
LOCAL_SFTP_DIR="/"

# Ensure the local download directory exists
mkdir -p "$LOCAL_DOWNLOAD_DIR"

echo "Starting SFTP file transfer..."

# Download files from the remote SFTP server
sftp -i "/home/johan/github.com/coderox/sftpgo-sandbox/$REMOTE_SFTP_USER.se.key" -oPort=2022 "$REMOTE_SFTP_USER@$REMOTE_SFTP_HOST" <<EOF
cd $REMOTE_SFTP_DIR
lcd $LOCAL_DOWNLOAD_DIR
mget *
bye
EOF

echo "Download complete."

# Upload files to the local SFTP server
sftp -i "/home/johan/github.com/coderox/sftpgo-sandbox/$LOCAL_SFTP_USER.se.key" -oPort=2022 "$LOCAL_SFTP_USER@$LOCAL_SFTP_HOST" <<EOF
cd $LOCAL_SFTP_DIR
lcd $LOCAL_DOWNLOAD_DIR
mput *
bye
EOF

echo "Upload complete."

# Clean up downloaded files
rm -rf "$LOCAL_DOWNLOAD_DIR"

echo "Transfer process finished."

exit 0