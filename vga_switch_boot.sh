#!/bin/sh -e

echo Allows access toswitcheroo

chown fredy:fredy /sys/kernel/debug/vgaswitcheroo/switch # change "username" with your user name
chown root:fredy /sys/kernel/debug
chmod g+rx /sys/kernel/debug
echo OFF > /sys/kernel/debug/vgaswitcheroo/switch

