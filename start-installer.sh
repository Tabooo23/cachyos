#!/usr/bin/env bash

set -o pipefail

SMB_USER="linux"
DEST="$HOME/cachyos"
MOUNT_POINT="/mnt/linux"
SHARE="//x.x.x.x/Linux"

UID_NUM="$(id -u)"
GID_NUM="$(id -g)"

# Install required packages
sudo pacman -S --needed cifs-utils rsync

read -r -s -p "SMB password: " SMB_PASS
echo

sudo mkdir -p "$MOUNT_POINT"
mkdir -p "$DEST"

CREDS="$(mktemp)"
chmod 600 "$CREDS"

printf 'username=%s\npassword=%s\n' "$SMB_USER" "$SMB_PASS" > "$CREDS"
unset SMB_PASS

MOUNTED=0

cleanup() {
    local status=$?

    if [ "$MOUNTED" -eq 1 ]; then
        sudo umount "$MOUNT_POINT" || true
    fi

    rm -f "$CREDS"
    exit "$status"
}

trap cleanup EXIT

if ! sudo mount -t cifs "$SHARE" "$MOUNT_POINT" \
    -o "credentials=$CREDS,vers=3.0,uid=$UID_NUM,gid=$GID_NUM"; then
    echo "Mount failed."
    exit 1
fi

MOUNTED=1

rsync -a --info=progress2 "$MOUNT_POINT/" "$DEST/"
COPY_STATUS=$?

if [ "$COPY_STATUS" -eq 0 ]; then
    echo "All files copied to: $DEST"
else
    echo "Copy failed."
fi

exit "$COPY_STATUS"