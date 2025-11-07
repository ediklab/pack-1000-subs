#!/bin/bash
#
# One-Liner Port Scanner en Bash
#
# Este script utiliza la funcionalidad nativa de Bash para intentar establecer una conexión TCP
# a un rango de puertos en una IP específica. Es útil para una enumeración rápida
# desde una máquina comprometida donde no hay herramientas como nmap, como por ejemplo
# desde dentro de un contenedor Docker/LXD.

# --- USO ---
# Modifica la IP_TARGET y ejecuta el script.
# O pásale la IP como primer argumento: ./bash_port_scanner.sh <IP>

IP_TARGET=${1:-"172.17.0.1"} # IP por defecto si no se pasa argumento (gateway común de Docker)
START_PORT=1
END_PORT=1000

echo "Escaneando puertos en $IP_TARGET..."

for PORT in $(seq $START_PORT $END_PORT); do
  (timeout 1 bash -c "</dev/tcp/$IP_TARGET/$PORT") &>/dev/null && echo "Puerto $PORT está abierto"
done

echo "Escaneo finalizado."

# --- EXPLICACIÓN DEL COMANDO ---
# for PORT in {1..1000}; do ... ; done
#   - Un bucle que itera por los puertos deseados.
#
# timeout 1 bash -c "..."
#   - `timeout 1`: Limita la espera a 1 segundo por puerto. Crucial para que no se cuelgue.
#   - `bash -c "..."`: Ejecuta el comando de conexión en un sub-shell.
#
# </dev/tcp/IP/PUERTO
#   - Esta es la magia de Bash. Intenta abrir una conexión de lectura/escritura al socket especificado.
#
# &>/dev/null
#   - Redirige tanto la salida estándar (stdout) como el error estándar (stderr) a /dev/null para silenciar los mensajes de "Connection refused".
#
# && echo "puerto $PORT is open"
#   - El operador `&&` (AND lógico) solo ejecuta el comando `echo` si el comando anterior (la conexión) tuvo éxito (exit code 0).
