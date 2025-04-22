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
	*)
	 return 1
	 ;;
  esac
}

while true; do
  read -rp "mi-terminal> " comando
  [[ -z "$comando" ]] && continue
  comandos "$comando"
  if [[ $? -eq 0 ]]; then
    continue
  fi
  eval "$comando"
done
