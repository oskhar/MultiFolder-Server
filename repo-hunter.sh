#!/bin/bash

# Tentukan Directory yang akan dihapus
directory="/srv/http"
echo "Melakukan proses penghapusan semua repository pada server"
# Periksa apakah Directory ada
if [ -d "$directory" ]; then
    # Tanyakan apakah hanya ingin menghapus satu repository
    read -p "Hanya hapus satu repository? [Y/n] " choice
    choice="${choice:-Y}" # Mengatur default jawaban menjadi Y jika tidak ada input

    if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
        # Minta nama repository yang akan dihapus
        read -p "Masukkan nama repository yang ingin dihapus: " repository_name

        # Periksa apakah repository ada
        if [ -d "$directory/$repository_name" ]; then
            # Hapus repository
            rm -rf "$directory/$repository_name"
            echo "Repository $repository_name telah dihapus."
        else
            echo "Repository $repository_name tidak ditemukan."
        fi
    elif [ "$choice" = "N" ] || [ "$choice" = "n" ]; then
        # Hapus semua file di dalam Directory
        rm -rf "$directory"/*

        # Hapus semua repository (rekursif)
        find "$directory" -type d -exec rm -rf {} +

        echo "Semua file dan repository di server telah dihapus."
    else
        echo "Pilihan tidak valid."
    fi
else
    echo "Directory $directory tidak ditemukan."
fi
