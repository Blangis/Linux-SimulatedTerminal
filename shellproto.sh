#!/bin/bash

trap '' SIGINT
trap '' SIGTSTP

function comandos(){
	
  case "$1" in 
	saludo)
	 echo "Hola!"
	 return 0 
	 ;;
	salir)
	 echo "adios"
	 exit 0
	;;
	ayuda)
	./ayuda.sh
	return 0
	;;
	buscar)
	./searchFile.sh
	return 0
	;;
	infosis)
	./infosis.sh
	return 0
	;;
	juego)
	./juego.sh
	return 0
	;;
	fecha)
	  echo "$(cat /sys/class/rtc/rtc0/date) $(cat /sys/class/rtc/rtc0/time)"
	;;
	hora)
	  echo "$(cat /sys/class/rtc/rtc0/date) $(cat /sys/class/rtc/rtc0/time)"
	;;
	musica)
	  ./reproductor.sh
	;;
	*)
	 return 1
	 ;;
  esac
}



while true; do
  read -rp "$(whoami) en $(basename "$PWD")  >>" comando
  [[ -z "$comando" ]] && continue
  comandos "$comando"
  if [[ $? -eq 0 ]]; then
    continue
  fi
  eval "$comando"
done
