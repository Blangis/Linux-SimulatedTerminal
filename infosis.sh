#!/bin/bash

#colores tput setaf
verde=$(tput setaf 2)
rojo=$(tput setaf 1)
azul=$(tput setaf 4)
amarillo=$(tput setaf 3)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)

reset=$(tput sgr0)
 
echo "${cyan}Memoria RAM:${magenta} $(grep MemTotal /proc/meminfo | cut -d ":" -f2 | xargs)${reset}"

if grep -q lm /proc/cpuinfo ; then 
	echo "${cyan}Arquitectura del sistema:${magenta}64 bits${reset}"
else 
	echo "${cyan}Arquitectura del sistema:${magenta}32 bits${reset}"
fi


echo "${cyan}Versión del SO:${magenta}$(grep -i "^version=" /etc/os-release | cut -d "=" -f2)${reset}"
