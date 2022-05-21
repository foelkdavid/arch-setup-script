#!/bin/sh
echo "START"                                                                                                                                 
chmod +x $PWD/add-ons/*
$PWD/add-ons/zsh.sh
$PWD/add-ons/nvim.sh
$PWD/add-ons/basics.sh
$PWD/add-ons/sources.sh
$PWD/add-ons/xorg.sh
$PWD/add-ons/cleanup.sh