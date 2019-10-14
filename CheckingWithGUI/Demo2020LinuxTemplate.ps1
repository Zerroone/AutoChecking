Param(
[string]$NAMELIN,
[string]$SERVERLIN,
[string]$LOGINSERVERLIN,
[string]$PASSSERVERLIN,
#[string]$PATHLIN,
[string]$DATA,
[string]$DIR
)
#$DIR = $PATHLIN + $NAMELIN + '.txt'
Set-PowerCLIConfiguration -DefaultVIServerMode Multiple -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer -Server $SERVERLIN -User $LOGINSERVERLIN -Password $PASSSERVERLIN
$LCLI = Get-VM -Name 'L-CLI'
$RCLI = Get-VM -Name 'R-CLI'
$LFW = Get-VM -Name 'L-FW'
$LSRV = Get-VM -Name 'L-SRV'
$OUTCLI = Get-VM -Name 'OUT-CLI'
$RFW = Get-VM -Name 'R-FW'
Start-VM -VM $LCLI -Confirm:$false
Start-VM -VM $RCLI -Confirm:$false
Start-VM -VM $LFW -Confirm:$false
Start-VM -VM $LSRV -Confirm:$false
Start-VM -VM $OUTCLI -Confirm:$false
Start-VM -VM $RFW -Confirm:$false

echo "Дата начала проверки:" $DATA | Out-File $DIR -Append -NoClobber
echo "Кто выполнял задание:" $NAMELIN | Out-File $DIR -Append -NoClobber


echo "###############################################################'L-CLI R-CLI' Hostnames#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "echo '';cat /etc/hostname" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI Hostnames command cat /etc/hostname') | Out-File $DIR

  Invoke-VMScript -vm $RCLI -ScriptText "echo '';cat /etc/hostname" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI Hostnames command cat /etc/hostname') | Out-File $DIR

 echo "###############################################################'L-CLI R-CLI' IPv4 connectivity#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "ping r-cli.skill39.wsr -c 4; ping 20.20.20.10 -c 4" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI IPv4 connectivity command ping r-cli.skill39.wsr -c 4; ping 20.20.20.10 -c 4') | Out-File $DIR

  Invoke-VMScript -vm $RCLI -ScriptText "ping 10.10.10.10 -c 4" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI IPv4 connectivity command ping 10.10.10.10 -c 4') | Out-File $DIR

  echo "###############################################################'L-FW R-FW' Software installation#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LFW -ScriptText "whereis tcpdump vim lynx" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-FW Software installation command whereis tcpdump vim lynx') | Out-File $DIR

  Invoke-VMScript -vm $RFW -ScriptText "whereis tcpdump vim lynx" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-FW Software installation command whereis tcpdump vim lynx') | Out-File $DIR

  echo "###############################################################'L-CLI R-CLI' Local hostname table#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "cat /etc/hosts" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI Local hostname table command cat /etc/hosts') | Out-File $DIR

  Invoke-VMScript -vm $RCLI -ScriptText "cat /etc/hosts" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI Local hostname table command cat /etc/hosts') | Out-File $DIR

  echo "###############################################################'L-CLI R-CLI' Name lookup order#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "cat /etc/nsswitch.conf" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI Name lookup order command cat /etc/nsswitch.conf | grep dns files') | Out-File $DIR

  Invoke-VMScript -vm $RCLI -ScriptText "cat /etc/nsswitch.conf" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI Name lookup order command cat /etc/nsswitch.conf | grep dns files') | Out-File $DIR

  echo "###############################################################'L-CLI' DHCP: Basic Operation #########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "ip a; dhclient -r; ip a; dhclient -v; ip a" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI DHCP-A: Basic Operation command dhclient -r; dhclient -v; ip a;ip r; cat /etc/resolv.conf') | Out-File $DIR

  echo "###############################################################'L-CLI' DHCP: Additional Parameters #########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "ip a;ip r; cat /etc/resolv.conf" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI DHCP-A: Additional Parameters command dhclient -r; dhclient -v; ip a;ip r; cat /etc/resolv.conf') | Out-File $DIR


  echo "###############################################################'L-CLI' DNS: ISP Forward zone#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "nslookup worldskills.ru" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI DNS: ISP Forward zone command nslookup worldskills.ru') | Out-File $DIR


  echo "###############################################################'L-CLI' DNS: Reverse zone#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $LCLI -ScriptText "host 172.16.20.10; host 192.168.20.10" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI DNS: Reverse zone command host 172.16.20.10; host 192.168.20.10') | Out-File $DIR


echo "###############################################################'R-CLI' DNS: Secondary DNS#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $RCLI -ScriptText "nslookup skill39.wsr; nslookup 20.20.20.10" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI DNS: Slave command nslookup skill39.wsr; nslookup 20.20.20.10') | Out-File $DIR


 echo "###############################################################'R-CLI L-CLI' DNS: Dynamic DNS#########################################################################" | Out-File $DIR -Append -NoClobber

 Invoke-VMScript -vm $RCLI -ScriptText "host L-CLI; host R-CLI" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI DNS: Dynamic DNS command host L-CLI; host R-CLI') | Out-File $DIR


 Invoke-VMScript -vm $LCLI -ScriptText "ifdown ens160" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI DNS: Dynamic DNS command ifdown ens160') | Out-File $DIR

 Invoke-VMScript -vm $RCLI -ScriptText "host L-CLI" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-FW DNS: Dynamic DNS command host L-CLI') | Out-File $DIR
  
  Invoke-VMScript -vm $LCLI -ScriptText "ifup ens160" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI DNS: Dynamic DNS command ifup ens160') | Out-File $DIR


 echo "###############################################################'L-FW R-FW' Internet Gateway (Dynamic NAT)#########################################################################" | Out-File $DIR -Append -NoClobber

Invoke-VMScript -vm $LFW -ScriptText "ping 10.10.10.10 -c 4; ping 20.20.20.10 -c 4; iptables -L -v -t nat " -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'L-FW Internet Gateway (Dynamic NAT) command ping 10.10.10.10 -c 4; ping 20.20.20.10 -c 4; iptables -L -v -t nat ') | Out-File $DIR

Invoke-VMScript -vm $RFW -ScriptText "ping 10.10.10.10 -c 4; ping 20.20.20.10 -c 4; iptables -L -v -t nat " -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'R-FW Internet Gateway (Dynamic NAT) command  ping 10.10.10.10 -c 4; ping 20.20.20.10 -c 4; iptables -L -v -t nat ') | Out-File $DIR

echo "###############################################################'L-SRV' LDAP: Users, Groups and OU#########################################################################" | Out-File $DIR -Append -NoClobber
 
 Invoke-VMScript -vm $LSRV -ScriptText "ldapsearch -x cn=user55 -b ou=Users,dc=skill39,dc=wsr;ldapsearch -x cn=tux -b ou=Users,dc=skill39,dc=wsr;ldapsearch -x cn=Admin -b ou=Groups,dc=skill39,dc=wsr" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'L-SRV LDAP: Users, Groups and OU command ldapsearch -x cn=user55 -b ou=Users,dc=skill39,dc=wsr;ldapsearch -x cn=tux -b ou=Users,dc=skill39,dc=wsr;ldapsearch -x cn=Admin -b ou=Groups,dc=skill39,dc=wsr') | Out-File $DIR

echo "###############################################################'L-CLI R-CLI' LDAP: Clients authentication#########################################################################" | Out-File $DIR -Append -NoClobber

if(Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP" -GuestUser 'user66' -GuestPassword 'P@ssw0rd' -ScriptType Bash)
{
 Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP Authentication from user user66 password P@ssw0rd YES" -GuestUser 'user66' -GuestPassword 'P@ssw0rd' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI LDAP: Clients authentication') | Out-File $DIR
}
else{
Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP Authentication from user user66 password P@ssw0rd NO" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI LDAP: Clients authentication') | Out-File $DIR
}

if(Invoke-VMScript -vm $RCLI -ScriptText "echo LDAP" -GuestUser 'tux' -GuestPassword 'toor' -ScriptType Bash)
{
 Invoke-VMScript -vm $RCLI -ScriptText "echo LDAP Authentication from user tux password toor YES" -GuestUser 'tux' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI LDAP: Clients authentication') | Out-File $DIR
}
else{
Invoke-VMScript -vm $RCLI -ScriptText "echo LDAP Authentication from user tux password toor NO" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-CLI LDAP: Clients authentication') | Out-File $DIR
}


echo "###############################################################'L-CLI L-SRV' LDAP: Logon restriction#########################################################################" | Out-File $DIR -Append -NoClobber

if(Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP" -GuestUser 'user66' -GuestPassword 'P@ssw0rd' -ScriptType Bash)
{
 Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP Authentication from user uer66 password P@ssw0rd YES" -GuestUser 'user66' -GuestPassword 'P@ssw0rd' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI LDAP: Clients authentication') | Out-File $DIR
}
else{
Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP Authentication from user uer66 password P@ssw0rd NO" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI LDAP: Clients authentication') | Out-File $DIR
}

if(Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP" -GuestUser 'tux' -GuestPassword 'toor' -ScriptType Bash)
{
 Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP Authentication from user tux password toor YES" -GuestUser 'tux' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI LDAP: Clients authentication') | Out-File $DIR
}
else{
Invoke-VMScript -vm $LCLI -ScriptText "echo LDAP Authentication from user tux password toor NO" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-CLI LDAP: Clients authentication') | Out-File $DIR
}

if(Invoke-VMScript -vm $LSRV -ScriptText "echo LDAP" -GuestUser 'user66' -GuestPassword 'P@ssw0rd' -ScriptType Bash)
{
 Invoke-VMScript -vm $LSRV -ScriptText "echo LDAP Authentication from user uer66 password P@ssw0rd YES" -GuestUser 'user66' -GuestPassword 'P@ssw0rd' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-SRV LDAP: Clients authentication') | Out-File $DIR
}
else{
Invoke-VMScript -vm $LSRV -ScriptText "echo LDAP Authentication from user uer66 password P@ssw0rd NO" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-SRV LDAP: Clients authentication') | Out-File $DIR
}

if(Invoke-VMScript -vm $LSRV -ScriptText "echo LDAP" -GuestUser 'tux' -GuestPassword 'toor' -ScriptType Bash)
{
 Invoke-VMScript -vm $LSRV -ScriptText "echo LDAP Authentication from user tux password toor YES" -GuestUser 'tux' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-SRV LDAP: Clients authentication') | Out-File $DIR
}
else{
Invoke-VMScript -vm $LSRV -ScriptText "echo LDAP Authentication from user tux password toor NO" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-SRV LDAP: Clients authentication') | Out-File $DIR
}


 echo "###############################################################Syslog: L-SRV auth.*#########################################################################" | Out-File $DIR -Append -NoClobber

   Invoke-VMScript -vm $LSRV -ScriptText "tail -n10 /opt/logs/L-SRV/auth.log" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-SRV Syslog: L-SRV auth.* messages command cat /opt/logs/L-SRV/auth.log') | Out-File $DIR

  echo "###############################################################Syslog: L-FW *.err#########################################################################" | Out-File $DIR -Append -NoClobber
  
   Invoke-VMScript -vm $LFW -ScriptText "logger -p err L-FW" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-FW Syslog: L-FW *.err command logger -p err TESTERROR') | Out-File $DIR

   Invoke-VMScript -vm $LSRV -ScriptText "tail -n10 /opt/logs/L-FW/error.log" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-SRV Syslog: L-SRV auth.* messages command tail -n10 /opt/logs/L-FW/error.log') | Out-File $DIR


 echo "###############################################################'L-FW' RA: OpenVPN basic#########################################################################" | Out-File $DIR -Append -NoClobber

         Invoke-VMScript -vm $LFW -ScriptText "ls /opt/vpn; netstat -npl | grep 1122; grep -v '^[# $]' /etc/openvpn/server.conf; ip a" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-FW RA: OpenVPN basic command ls /opt/vpn; netstat -npl | grep 1122; grep -v "^[# $]" /etc/openvpn/server.conf; ip a') | Out-File $DIR

 echo "###############################################################'OUT-CLI' RA: VPN Clients have full access to LEFT and RIGHT LANs#########################################################################" | Out-File $DIR -Append -NoClobber

         Invoke-VMScript -vm $OUTCLI -ScriptText "ip a; ls /opt/vpn; cd /var ; stop_vpn.sh ; sleep 5; ping 5.5.5.1 -c 4 ;start_vpn.sh; sleep 5 ; ip a; ping 5.5.5.1 -c 4" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'OUT-CLI RA: RA: VPN Clients have full access to LEFT and RIGHT LANs command ip a; ls /opt/vpn; cd /var ; stop_vpn.sh ; sleep 5; ping 5.5.5.1 -c 4 ;start_vpn.sh; sleep 5 ; ip a; ping 5.5.5.1 -c 4') | Out-File $DIR

 
 echo "###############################################################'L-FW R-FW' GRE Tunnel Cinnectivity#########################################################################" | Out-File $DIR -Append -NoClobber

         Invoke-VMScript -vm $LFW -ScriptText "ping 10.5.5.1 -c 4; ping 10.5.5.2 -c 4" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'L-FW GRE Tunnel Cinnectivity command ping 10.5.5.1 -c 4; ping 10.5.5.2 -c 4') | Out-File $DIR

  Invoke-VMScript -vm $RFW -ScriptText "ping 10.5.5.1 -c 4; ping 10.5.5.2 -c 4" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'R-FW GRE Tunnel Cinnectivity command ping 10.5.5.1 -c 4; ping 10.5.5.2 -c 4') | Out-File $DIR


 echo "###############################################################'OUT-CLI' SSH: Users#########################################################################" | Out-File $DIR -Append -NoClobber

         Invoke-VMScript -vm $OUTCLI -ScriptText "sshpass -p P@ssw0rd ssh -o 'StrictHostKeyChecking no' ssh_c@vpn.skill39.wsr" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'OUT-CLI SSH: Users command sshpass -p toor ssh -o StrictHostKeyChecking no root@vpn.skill39.wsr') | Out-File $DIR

 
echo "###############################################################'OUT-CLI' SSH: Key authentication#########################################################################" | Out-File $DIR -Append -NoClobber

         Invoke-VMScript -vm $OUTCLI -ScriptText "timeout 10 ssh ssh_p@vpn.skill39.wsr" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
 (Get-Content $DIR).replace('ScriptOutput', 'OUT-CLI SSH: Key authentication command sshpass -p toor ssh vpn.skill39.wsr') | Out-File $DIR


 echo "###############################################################'L-CLI R-CLi OUT-CLI' Web: http/s www.skill39.wsr , Web: Trusted SSL , Web: http –> https#########################################################################" | Out-File $DIR -Append -NoClobber

Invoke-VMScript -vm $LCLI -ScriptText "curl -L http://www.skill39.wsr" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'L-CLI-A Web: http/s www.skill39.wsr, Web: Trusted SSL , Web: http –> https command curl -L http://www.skill39.wsr ') | Out-File $DIR

Invoke-VMScript -vm $RCLI -ScriptText "curl -L http://www.skill39.wsr" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'L-CLI-B Web: http/s www.skill39.wsr , Web: Trusted SSL , Web: http –> https command curl -L http://www.skill39.wsr') | Out-File $DIR

Invoke-VMScript -vm $OUTCLI -ScriptText "curl -L http://www.skill39.wsr" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'OUT-CLI Web: http/s www.skill39.wsr , Web: Trusted SSL , Web: http –> https command curl -L http://www.skill39.wsr') | Out-File $DIR

 
 echo "###############################################################'R-FW' OpenSSL: CA#########################################################################" | Out-File $DIR -Append -NoClobber
 
 Invoke-VMScript -vm $RFW -ScriptText "ls /etc/ca; openssl ca" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'R-FW OpenSSL: CA command ls /etc/ca') | Out-File $DIR

 echo "###############################################################'R-FW' Certificate Attributes#########################################################################" | Out-File $DIR -Append -NoClobber

  Invoke-VMScript -vm $RFW -ScriptText "cat /etc/ca/cacert.pem" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'R-FW Certificate Attributes command cat /etc/ca/cacert.pem') | Out-File $DIR

 echo "###############################################################'L-FW R-FW' IPTables: Block input traffic IPTables: DNS port forwarding IPTables: Allow GRE & IPSec IPTables: Allow SSH IPTables: Allow VPN IPTables: No Access to www.skill39.wsr via OpenVPN IPTables: HTTP/HTTPS#########################################################################" | Out-File $DIR -Append -NoClobber

   Invoke-VMScript -vm $RFW -ScriptText "iptables -L -v -n -t filter; iptables -L -v -n -t nat" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'R-FW IPTables: Block input traffic IPTables: DNS port forwarding IPTables: Allow GRE & IPSec IPTables: Allow SSH IPTables: Allow VPN IPTables: No Access to www.skill39.wsr via OpenVPN IPTables: HTTP/HTTPS command iptables -L -v -n -t filter; iptables -L -v -t nat') | Out-File $DIR

Invoke-VMScript -vm $LFW -ScriptText "iptables -L -v -n -t filter; iptables -L -v -n -t nat" -GuestUser 'root' -GuestPassword 'toor' -ScriptType Bash | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'L-FW IPTables: Block input traffic IPTables: DNS port forwarding IPTables: Allow GRE & IPSec IPTables: Allow SSH IPTables: Allow VPN IPTables: No Access to www.skill39.wsr via OpenVPN IPTables: HTTP/HTTPS command iptables -L -v -n -t filter; iptables -L -v -t nat') | Out-File $DIR