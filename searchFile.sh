#!/bin/bash

clear

#colores tput setaf
verde=$(tput setaf 2)
rojo=$(tput setaf 1)
azul=$(tput setaf 4)
amarillo=$(tput setaf 3)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)

reset=$(tput sgr0)

tput cup 1 2
echo "${magenta}Busquemos un archivo${reset}"

read -p "¿Qué archivo deseas buscar?" archivo
read -p "¿Qué carpeta deseas revisar?" carpeta

path="$HOME"

directorio="$path/$carpeta"

if [ ! -d "$directorio" ]; then
	echo "${rojo}El directorio NO existe${reset}" 
	exit 1
fi

busqueda=$(find "$directorio" -type f -name "$archivo" 2>/dev/null)

if [ -z "$busqueda" ]; then
	echo "${rojo}No se encontró el archivo en '$directorio'${reset}"
else 
	echo "${verde} Archivo encontrado en ${amarillo}'$busqueda'${reset}"
fi


