#!/bin/bash
clear
echo "Vamos a jugar ahorcado, trata de adivinar la palabra:"

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
echo "Vidas: $vidas"
echo "Errores: $errores/$vidas_tot"
echo -n "Ingresa una letra: " 
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
	echo "¡Felicidades, adivinaste la palabra!"
	echo "Palabra: ${palabra}"
	break
fi

if [ $vidas -le 0 ]; then 
	echo "Has perdido :( , la palabra era: $palabra"
	break
fi
done





