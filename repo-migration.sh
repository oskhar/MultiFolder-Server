#!/bin/bash

# Ambil nama folder saat ini
CURRENT_DIR_NAME=$(basename "$(pwd)")

# Ambil direktori kerja saat ini
CURRENT_DIR=$(pwd)

# Tampilkan direktori kerja saat ini
echo "Direktori kerja saat ini adalah: $CURRENT_DIR"

# Prompt untuk input pengguna dengan default 'Y'
read -p "Auto deteksi folder? [Y/n] " INCLUDE_FOLDER
INCLUDE_FOLDER=${INCLUDE_FOLDER:-Y}

# Fungsi untuk menyalin dengan membuat direktori tujuan jika belum ada
copy_files() {
    DEST_DIR="/srv/http/$CURRENT_DIR_NAME"
    if [ ! -d "$DEST_DIR" ]; then
        mkdir -p "$DEST_DIR"
    fi
    cp -r -v -f "$CURRENT_DIR"/* "$DEST_DIR/"
}

# Jika pengguna memilih 'Y' atau tidak mengisi (default 'Y')
if [[ "$INCLUDE_FOLDER" =~ ^[Yy]$ ]]; then
    echo "Menyertakan folder dan menyalin ke /srv/http/$CURRENT_DIR_NAME"
    copy_files
else
    echo "Tidak menyertakan folder. Menyalin file ke /srv/http/"
    cp -r -v -f "$CURRENT_DIR"/* /srv/http/
fi
