# 🎉 PACK 1000 SUBS - RED TEAM & OSCP TOOLKIT

**@3diklab | TikTok Cybersecurity Community**

Gracias por ser parte de los primeros **1000 followers**. 🕶️

Este pack es tu arsenal completo y **curado** para red team y preparación OSCP.

---

## ⚠️ DISCLAIMER ÉTICO - LEE ESTO PRIMERO

### 🚨 IMPORTANTE: Este contenido es EXCLUSIVAMENTE educativo.

#### ✅ **USAR PARA:**
- ✅ **Tu propio laboratorio** (VMs locales, entornos controlados)
- ✅ **Sistemas con autorización ESCRITA** (pentesting contratado)
- ✅ **Plataformas legales**: HackTheBox, TryHackMe, PentesterLab, OverTheWire
- ✅ **Certificaciones**: OSCP, OSWE, OSEP, PNPT, eCPPT
- ✅ **Aprendizaje personal** en entornos autorizados

#### ❌ **NUNCA USAR PARA:**
- ❌ Sistemas sin autorización **EXPLÍCITA Y ESCRITA**
- ❌ Acceso no autorizado a redes, servidores o dispositivos
- ❌ Causar daño, interrumpir servicios o eliminar datos
- ❌ Actividades ilegales de cualquier tipo
- ❌ Violar leyes locales, nacionales o internacionales

### ⚖️ RESPONSABILIDAD LEGAL

**El autor (@3diklab) NO es responsable por el uso indebido de este contenido.**

- El uso no autorizado de estas técnicas es **ILEGAL** y puede resultar en:
  - Cargos criminales
  - Multas significativas
  - Prisión
  - Antecedentes penales permanentes

- **Siempre obtén autorización escrita** antes de realizar cualquier tipo de test de penetración.

- Este pack está diseñado para **educación, investigación de seguridad y pentesting ético autorizado**.

### 🛡️ CÓDIGO DE CONDUCTA

Si usas este pack, te comprometes a:

1. **Respetar la privacidad y propiedad** de otros
2. **Obtener permisos explícitos** antes de testear sistemas
3. **Reportar vulnerabilidades responsablemente** (no explotar para beneficio personal)
4. **Usar el conocimiento para defender**, no para atacar
5. **Seguir las leyes** de tu jurisdicción

---

## 📦 CONTENIDO DEL PACK

```
pack-1000-subs/
│
├── 🔥 GOLD_ONELINERS.txt       # Top 15 comandos que SÍ usarás
│                               # (Reverse shells, PrivEsc, Pivoting, Recon)
│
├── SCRIPTS/
│   ├── luvliscan               # Scanner adaptivo (escanea solo puertos nuevos)
│   ├── bash_port_scanner.sh    # Port scan sin nmap (post-exploitation)
│   ├── udp_scanner             # UDP scanning wrapper
│   └── privesc_check.sh        # Enumeración PrivEsc automatizada
│
├── DOCS/
│   └── OSCP_CHEAT_SHEET.md    # Una página de oro puro (metodología completa)
│
└── README.md                   # Este archivo
```

### 🔥 GOLD_ONELINERS.txt
- **15 comandos** cuidadosamente seleccionados
- Reverse shells (Bash, Python, Netcat, PHP, PowerShell)
- TTY upgrade completo
- PrivEsc quick wins (SUID, SUDO, Capabilities)
- Network pivoting (SSH, Chisel)
- Recon sin nmap (post-exploitation)

### 🛠️ SCRIPTS

#### 1. **luvliscan**
Scanner adaptivo inteligente que solo escanea **puertos nuevos** en ejecuciones posteriores.

```bash
./luvliscan 10.10.10.5 Oopsie
```

**Características:**
- Escaneo inicial completo (TCP all ports)
- Guarda estado (evita escaneos redundantes)
- Service enumeration automático
- Organiza resultados por máquina

#### 2. **bash_port_scanner.sh**
Port scanner **sin dependencias** (solo Bash nativo).

```bash
./bash_port_scanner.sh 172.17.0.1
```

**Uso:** Post-exploitation cuando no tienes nmap disponible (contenedores, sistemas restringidos).

#### 3. **udp_scanner**
Wrapper para nmap UDP scanning (notoriamente lento).

```bash
./udp_scanner 10.10.10.5           # Top 1000 UDP ports
./udp_scanner 10.10.10.5 --full    # All 65535 (VERY slow)
```

#### 4. **privesc_check.sh**
Enumeración automatizada de vectores de escalación de privilegios en Linux.

```bash
./privesc_check.sh
```

**Genera reporte** con:
- SUDO privileges
- SUID/SGID binaries
- Capabilities
- Writable files
- Cron jobs
- Passwords en archivos
- SSH keys
- Docker/LXD membership
- PATH hijacking opportunities

### 📖 DOCS

#### OSCP_CHEAT_SHEET.md
Una página con **todo lo esencial**:
- Metodología completa (Recon → Enum → Exploit → PrivEsc)
- Port scanning (nmap one-liners)
- Web attacks (SQLi, LFI, Command Injection)
- Reverse shells (Linux & Windows)
- TTY upgrade
- Linux PrivEsc (SUDO, SUID, Capabilities)
- Windows PrivEsc (unquoted paths, AlwaysInstallElevated)
- File transfer methods
- Pivoting & tunneling (SSH, Chisel)
- Buffer Overflow methodology
- Recursos útiles (GTFOBins, HackTricks, etc.)

---

## 🚀 QUICK START

### 1. Descargar el pack
```bash
# Si está en GitHub
git clone https://github.com/yourusername/pack-1000-subs.git
cd pack-1000-subs

# O extraer ZIP
unzip pack-1000-subs.zip
cd pack-1000-subs
```

### 2. Dar permisos de ejecución
```bash
chmod +x SCRIPTS/*
```

### 3. Leer el cheat sheet
```bash
cat DOCS/OSCP_CHEAT_SHEET.md
```

### 4. Revisar los one-liners
```bash
cat GOLD_ONELINERS.txt
```

### 5. Probar en tu lab
```bash
# Ejemplo: Escanear una máquina HTB
./SCRIPTS/luvliscan 10.10.10.5 Oopsie

# Enumerar PrivEsc
./SCRIPTS/privesc_check.sh
```

---

## 🎯 CASOS DE USO

### HackTheBox
```bash
# 1. Escaneo inicial
./SCRIPTS/luvliscan 10.10.10.X MachineName

# 2. Si encuentras un shell, enumerar PrivEsc
./SCRIPTS/privesc_check.sh

# 3. Si no tienes nmap dentro del target
./SCRIPTS/bash_port_scanner.sh 172.17.0.1
```

### OSCP Labs
```bash
# 1. Consultar metodología
cat DOCS/OSCP_CHEAT_SHEET.md

# 2. Copiar reverse shell del one-liner
cat GOLD_ONELINERS.txt

# 3. Automatizar enumeración
./SCRIPTS/privesc_check.sh > enumeration_report.txt
```

### CTFs
```bash
# Quick reference para comandos comunes
grep -i "reverse shell" GOLD_ONELINERS.txt
grep -i "privesc" GOLD_ONELINERS.txt
```

---

## 💡 MEJORES PRÁCTICAS

### 1. **Documentación**
- Toma screenshots de TODO
- Documenta cada comando ejecutado
- Guarda los reportes de los scripts

### 2. **Metodología**
- Sigue el orden: Recon → Enum → Exploit → PrivEsc
- No te saltes la enumeración (es donde está el gold)
- Lee los reportes completos antes de explotar

### 3. **OSCP Tips**
- **Try Harder™**: Enumera más antes de usar Metasploit
- Usa los scripts para automatizar, pero entiende qué hacen
- GTFOBins es tu mejor amigo para SUID/SUDO exploits

### 4. **Seguridad**
- Trabaja siempre en entornos aislados
- No guardes credenciales reales en scripts
- Limpia tus traces después de practicar

---

## 🔗 RECURSOS ADICIONALES

### Plataformas de Práctica
- **HackTheBox**: https://www.hackthebox.com/
- **TryHackMe**: https://tryhackme.com/
- **PentesterLab**: https://pentesterlab.com/
- **OverTheWire**: https://overthewire.org/

### Referencias
- **GTFOBins**: https://gtfobins.github.io/ (SUID/SUDO exploits)
- **RevShells**: https://www.revshells.com/ (reverse shell generator)
- **HackTricks**: https://book.hacktricks.xyz/ (técnicas de pentesting)
- **PayloadsAllTheThings**: https://github.com/swisskyrepo/PayloadsAllTheThings
- **ExploitDB**: https://www.exploit-db.com/

### Herramientas Complementarias
- **LinPEAS**: https://github.com/carlospolop/PEASS-ng (Linux PrivEsc)
- **WinPEAS**: https://github.com/carlospolop/PEASS-ng (Windows PrivEsc)
- **pspy**: https://github.com/DominicBreuker/pspy (monitor procesos sin root)

---

## 💬 COMUNIDAD

### ¿Dudas? ¿Sugerencias? ¿Encontraste un bug?

- **TikTok**: [@3diklab](https://tiktok.com/@3diklab) (sígueme para más contenido)
- **GitHub**: Abre un issue o PR si encuentras mejoras
- **Comentarios**: Déjame un comentario en TikTok con feedback

---

## 📝 CHANGELOG

### v1.0 (Nov 2024) - Initial Release
- ✅ GOLD_ONELINERS.txt con 15 comandos esenciales
- ✅ luvliscan (scanner adaptivo inteligente)
- ✅ bash_port_scanner.sh (post-exploitation)
- ✅ udp_scanner (UDP wrapper)
- ✅ privesc_check.sh (enumeración automatizada)
- ✅ OSCP_CHEAT_SHEET.md (metodología completa)

---

## 🙏 AGRADECIMIENTOS

Gracias a los primeros **1000 followers** por el apoyo.

Este pack es para ti, para la comunidad, y para todos los que están en su journey de ciberseguridad.

**Compártelo, úsalo, mejóralo.** Pero siempre de forma ética. 🕶️

---

## 📜 LICENCIA

Este proyecto se distribuye bajo **MIT License** para fines educativos.

**Restricciones adicionales:**
- No usar para actividades ilegales
- No usar sin autorización explícita
- Respetar las leyes locales e internacionales
- El autor no se responsabiliza por el uso indebido

---

## 🎓 FILOSOFÍA

> "With great power comes great responsibility."

El pentesting ético requiere:
- 🧠 **Conocimiento técnico**
- ⚖️ **Responsabilidad legal**
- 🛡️ **Integridad moral**

Este pack te da el primero. Los otros dos dependen de ti.

---

**🕶️ Made with ❤️ by @3diklab**

**🔥 1000 Subs Milestone - Nov 2024**

**🚀 Para la comunidad, por la comunidad**

---

*Stay curious. Stay ethical. Try harder.*
