#!/bin/bash
clear
#pongo colores random, no necesariamente corresponden
verde_elect=$(tput setaf 154)
rojo=$(tput setaf 1)
rosa=$(tput setaf 197)
morado=$(tput setaf 165)
amarillo=$(tput setaf 226)
naranja=$(tput setaf 9)
cyan=$(tput setaf 6)
blanco=$(tput setaf 15)
reset=$(tput sgr0)


echo "${amarillo}Vamos a jugar ahorcado, trata de adivinar la palabra:${reset}"

palabras=("linux" "computadora" "sistema operativo" "comando" "terminal")
num_palabras=${#palabras[@]}

indice=$(expr $RANDOM % $num_palabras)
palabra="${palabras[$indice]}"
longitud=${#palabra}
progreso=""

for ((i=0; i<longitud; i++)); do
	letra="${palabra:$i:1}"
	if [ "$letra" = " " ];then	
		progreso+="  "
	else
		progreso+="_ "
	fi
done

vidas=6
vidas_tot=6
errores=0


while true; do
echo ""
echo "$progreso"
echo "${rosa}Vidas: $vidas${reset}"
echo "${rojo}Errores: $errores/$vidas_tot${reset}"
echo -n "${morado}Ingresa una letra${reset}: " 
read -n1 letra
echo ""

encontrado=false
nuevo_progreso=""

#${progreso:posicion:largo} corta parte de progreso,
# posicion:donde empieza; largo: cuantos char tomar
for ((i=0; i<longitud; i++)); do
	letra_act="${palabra:$i:1}"
	letra_progreso="${progreso:$((i*2)):1}"

	if [ "$letra_act" = "$letra" ]; then
		nuevo_progreso+="$letra_act "
		encontrado=true
	else
		nuevo_progreso+="$letra_progreso "
	fi
done

progreso="$nuevo_progreso"

if [ "$encontrado" = false ]; then 
	((errores++))
	((vidas--))
fi

if [[ "$progreso" != *"_"* ]]; then
	echo "${verde_elect}¡Felicidades, adivinaste la palabra!${reset}"
	echo "${verde_elect}Palabra:${cyan} ${palabra}${reset}"
	break
fi

if [ $vidas -le 0 ]; then 
	echo "${cyan}Has perdido :( , la palabra era: $palabra${reset}"
	break
fi
done





