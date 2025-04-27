#!/bin/bash
indice_actual=0
play(){
  local song=$1
  mpg123 "$song" > /dev/null 2>&1 &
  MP3_PID=$!
}

stop(){
  if [ -n "$MP3_PID" ]; then 
    kill "$MP3_PID"
    MP3_PID=""
  fi
}


seleccion_folder(){
  directorio=$(dialog --title "Selecciona una carpeta" --dselect $HOME/ 14 48 3>&1 1>&2 2>&3)
  if [ -n "$directorio" ]; then
    lista=($(find "$directorio" -type f -name "*.mp3"))
    indice_actual=0
    if [ ${#lista[@]} -eq 0 ]; then
      dialog --msgbox "No se encontraron archivos MP3 en este directorio." 6 50
    fi
  fi
}

seleccion_cancion(){
  cancion=$(dialog --title "Seleccionar Canción" --menu "Elige una canción:" 15 50 5 $(for a in "${lista[@]}"; do echo "$a $a"; done) 3>&1 1>&2 2>&3)
  if [ -n "$cancion" ]; then
    for i in "${!lista[@]}"; do
      if [[ "${lista[$i]}" == "$cancion" ]]; then
        indice_actual=$i
        break
      fi
    done
    play "$cancion"
  fi
}


while true; do
  opcion=$(dialog --menu "Reproductor MP3" 15 50 5 \
  "1" "Seleccionar carpeta"\
  "2" "Siguiente cancion"\
  "3" "Anterior cancion"\
  "4" "Detener"\
  "5" "Salir"\
  3>&1 1>&2 2>&3)

  case $opcion in 
    1)
      seleccion_folder
      seleccion_cancion
      ;;
    2)
      if [ -n "$MP3_PID" ]; then
        stop
        ((indice_actual++))
        if [ "$indice_actual" -ge "${#lista[@]}" ]; then
          indice_actual=0
        fi
        siguiente="${lista[$indice_actual]}"
        play "$siguiente"
      else
        dialog --msgbox "No se está reproduciendo ninguna canción." 6 40
      fi
      ;;
    3)
      if [ -n "$MP3_PID" ]; then
        stop
        ((indice_actual--))
        if [ "$indice_actual" -lt 0 ]; then
          indice_actual=$((${#lista[@]} - 1))
        fi
        anterior="${lista[$indice_actual]}"
        play "$anterior"
      else
        dialog --msgbox "No se está reproduciendo ninguna canción." 6 40
      fi
    ;;
    4)
      stop
    ;;
    5)
      stop
      clear
      exit 0
    ;;
    *)
      dialog --msgbox "Opcion no valida" 6 40
      ;;
  esac
done