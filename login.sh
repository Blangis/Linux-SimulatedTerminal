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

first="╔═══════════════════════════════════════════╗"
second="║                 Bienvenida                ║"
third="╚═══════════════════════════════════════════╝"

#print the mark
tput cup 2 10
echo "$first"
tput cup 3 10
echo "$second"
tput cup 4 10
echo "$third"

for i in {1..6}; do
	color=$(tput setaf $i)

	tput cup 2 10
	echo -n "${color}$first${reset}"

	tput cup 3 10 
	echo -n "${color}$second${reset}"

	tput cup 4 10
	echo -n "${color}${third}${reset}"

	sleep 0.3
done
	
tput cup 6 0	

read -p "¿Cuál es tu nombre de usuario?" usuario
read -s -p "Ingrese contraseña: " pwd
echo ""

if echo $pwd | su -c "exit" "$usuario" %>/dev/null; then
	echo "${verde}Autenticación exitosa, $usuario${reset}"
	sleep 2
	clear
	terminal.sh
else
	echo "${rojo}Acceso denegado${reset}"
	exit 1
fi
