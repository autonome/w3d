#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

IMG_FILE=$1
SECTOR_OFFSET=$(sudo /sbin/fdisk -lu $IMG_FILE | awk '$7 == "Linux" { print $2 }')
echo $SECTOR_OFFSET
BYTE_OFFSET=$(expr 512 \* $SECTOR_OFFSET)

IMG_DIR=$(basename "$IMG_FILE")
IMG_DIR="${IMG_DIR%.*}"

echo Mounting at /mnt/$IMG_DIR

mkdir -p /mnt/$IMG_DIR
mount -o loop,offset=$BYTE_OFFSET $IMG_FILE /mnt/$IMG_DIR

TMP_DIR=/mnt/$IMG_DIR/tmp/updater
mkdir -p $TMP_DIR
cp -r $DIR/* $TMP_DIR/
chroot /mnt/$IMG_DIR /tmp/updater/chroot.sh
rm -rf $TMP_DIR
umount /mnt/$IMG_DIR
