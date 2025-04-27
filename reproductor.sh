#!/bin/bash

programa="mpg123"
interfaz="dialog"

if command -v "$programa"  &> /dev/null; then
  echo "$programa esta instalado"
else
  echo "$programa  no esta instalado"
  sudo apt update
  sudo apt install -y "$programa"
  mpg123 --version
fi

if command -v "$interfaz" &> /dev/null; then 
  echo "$interfaz esta instalado"
else
  echo "$interfaz no esta instalado"
  sudo apt update
  sudo apt install -y "$interfaz"
fi


if command -v "$interfaz" &> /dev/null && command -v "$programa"  &> /dev/null; then 
  ./interfaz.sh
else
  null
fi