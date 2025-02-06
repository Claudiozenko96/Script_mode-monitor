#!/bin/bash
# by: Claudio zenko 

#detecta el adaptador de red inalambrica
INTERFACE=$(iwconfig 2>/dev/null | grep 'IEEE 802.11' | awk '{print$1}')

if [ -z "$INTERFACE" ]; then 
	echo "  [-] No se encontro el adaptador de red inalambrico"
	exit 1
fi

echo "adaptador encontrado: $INTERFACE"

#aqui desactivamos la interfaz de red
sudo ifconfig $INTERFACE down

#Cambiar a modo monitor
echo "Cambiando a modo monitor.."
sudo iwconfig $INTERFACE mode monitor

#Reactivamos la interfaz de red
sudo ifconfig $INTERFACE up

#Verificar el estado actual
echo "Estado de la interfaz:"
iwconfig $INTERFACE

#Preguntar si quiere volver al modo managed

read -p "Quieres volver al modo managed? (s/n): " respuesta
if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then

	#desactivar la interfaz 
	sudo ifconfig $INTERFACE down
	sudo iwconfig $INTERFACE mode managed 
	sudo ifconfig $INTERFACE up
	echo "Interfaz en modo managed.."
	iwconfig $INTERFACE
fi

echo "proceso finalizado.."












