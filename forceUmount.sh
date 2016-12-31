#!/bin/sh

echo "Force umount SMB"
umount -f -a -t cifs -l 
