Param(
[string]$NAMEWIN,
[string]$SERVERWIN,
[string]$LOGINSERVERWIN,
[string]$PASSSERVERWIN,
#[string]$PATHWIN,
[string]$DATA,
[string]$DIR
)
#$DIR = $PATHLIN + $NAMELIN + '.txt'
Set-PowerCLIConfiguration -DefaultVIServerMode Multiple -InvalidCertificateAction Ignore -Confirm:$false
Connect-VIServer -Server $SERVERWIN -User $LOGINSERVERWIN -Password $PASSSERVERWIN
$DC1 = Get-VM -Name 'DC1'
$DC2 = Get-VM -Name 'DC2'
$CLI1 = Get-VM -Name 'CLI1'
$SRV1 = Get-VM -Name 'SRV1'
$DCA = Get-VM -Name 'DCA'
$BRIDGE1 = Get-VM -Name 'BRIDGE1'
$BRIDGE2 = Get-VM -Name 'BRIDGE2'
$SRV2 = Get-VM -Name 'SRV2'
$CLI2 = Get-VM -Name 'CLI2'
Start-VM -VM $DC1 -Confirm:$false
Start-VM -VM $DC2 -Confirm:$false
Start-VM -VM $CLI1 -Confirm:$false
Start-VM -VM $SRV1 -Confirm:$false
Start-VM -VM $DCA -Confirm:$false
Start-VM -VM $LCLI -Confirm:$false
Start-VM -VM $BRIDGE1 -Confirm:$false
Start-VM -VM $BRIDGE2 -Confirm:$false
Start-VM -VM $CLI2 -Confirm:$false
Start-VM -VM $SRV2 -Confirm:$false

echo "Дата начала проверки:" $DATA | Out-File $DIR -Append -NoClobber
echo "Кто выполнял задание:" $NAMEWIN | Out-File $DIR -Append -NoClobber


echo "###############################################################'DC1: Hostname'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "systeminfo" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber #DHCP service scope
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Hostname "command systeminfo"') | Out-File $DIR

echo "###############################################################'DC1: IP/MASK'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "ipconfig /all" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: IP/MASK "command ipconfig /all"') | Out-File $DIR

echo "###############################################################'DC1: Ping allow'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "ping BRIDGE1" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Ping allow "command ping BRIDGE1"') | Out-File $DIR

echo "###############################################################'DC1: Domain Pest.com'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "systeminfo" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Domain Pest.com "command systeminfo"') | Out-File $DIR

echo "###############################################################'DC1: Domain Pest.com'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "systeminfo" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Domain Pest.com "command systeminfo"') | Out-File $DIR

echo "###############################################################'DC1: DHCP service scope'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "Get-DhcpServerv4Scope | Format-List" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: DHCP service scope "command Get-DhcpServerv4Scope | Format-List"') | Out-File $DIR

echo "###############################################################'DC1: DNS service zone AND records'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "get-dnsserverzone" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: DNS service zone AND records "command get-dnsserverzone"') | Out-File $DIR

echo "###############################################################'DC1: Users from excel is enabled with correct password'#########################################################################" | Out-File $DIR -Append -NoClobber
if(Invoke-VMScript -vm $CLI1 -ScriptText "echo LOGIN FOR CLI1 YES user:AhmedMontgomery password:P@ssw0rd1" -GuestUser 'AhmedMontgomery@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell){
Invoke-VMScript -vm $CLI1 -ScriptText "echo LOGIN FOR CLI1 YES user:AhmedMontgomery password:P@ssw0rd1" -GuestUser 'AhmedMontgomery@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Users from excel is enabled with correct password') | Out-File $DIR
}
else{
echo "LOGIN FOR CLI1 NO user:AhmedMontgomery password:P@ssw0rd1" | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Users from excel is enabled with correct password') | Out-File $DIR
}

echo "###############################################################'DC1: Domain group'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "net group" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Domain group "command net group"') | Out-File $DIR

echo "###############################################################'DC1: Corret users in correct groups'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "get-adgroupmember -Identity Managers | Format-List" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Corret users in correct groups "command get-adgroupmember -Identity Managers | Format-List"') | Out-File $DIR

echo "###############################################################'DC1: No first sign animation/Default Home Page for Edge and IE/Local admin GPO/Folder redirection/Calculator folder exist on desktop (Correct only 2 GPO)'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText 'get-gporeport -all -path c:\gpo.xml -reporttype xml; [xml] $gpo = Get-Content c:\gpo.xml; $gpo.report.GPO.Computer.extensiondata.extension.policy | Format-Table -AutoSize -Property State,Name' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: No first sign animation/Default Home Page for Edge and IE/Local admin GPO/Folder redirection/Calculator folder exist on desktop (Correct only 2 GPO) command "get-gporeport -all -path c:\gpo.xml -reporttype xml; [xml] $gpo = Get-Content c:\gpo.xml; $gpo.report.GPO.Computer.extensiondata.extension.policy | Format-Table -AutoSize -Property State,Name "') | Out-File $DIR

echo "###############################################################'DC1: Domain clients'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "get-adcomputer -filter *" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: Domain clients "command get-adcomputer -filter *"') | Out-File $DIR

echo "###############################################################'SRV1: Secondary domain controller'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $SRV1 -ScriptText "get-addomaincontroller" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'SRV1: Secondary domain controller "command get-addomaincontroller"') | Out-File $DIR

echo "###############################################################'SRV1: RAID-5/RAID-1/RAID-0'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $SRV1 -ScriptText 'echo "list volume" | out-file C:\script.txt -Encoding utf8; diskpart /s C:\script.txt' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'SRV1: RAID-5/RAID-1/RAID-0 command "echo list volume | out-file C:\script.txt -Encoding utf8; diskpart /s C:\script.txt"') | Out-File $DIR

echo "###############################################################'SRV1: Secondary DNS'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $SRV1 -ScriptText 'get-dnsserverzone' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'SRV1: Secondary DNS command "get-dnsserverzone"') | Out-File $DIR

echo "###############################################################'SRV1: DHCP-failover'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $SRV1 -ScriptText 'Get-DhcpServerv4Failover' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'SRV1: DHCP-failover command "Get-DhcpServerv4Failover"') | Out-File $DIR

echo "###############################################################'SRV1: Shared folders'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $SRV1 -ScriptText 'net share' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'SRV1: Shared folders command "net share"') | Out-File $DIR

echo "###############################################################'SRV1: Department folder'#########################################################################" | Out-File $DIR -Append -NoClobber
if (Invoke-VMScript -vm $CLI1 -ScriptText 'LOGIN YES' -GuestUser 'RaphaelBird@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber){
Invoke-VMScript -vm $CLI1 -ScriptText 'net use' -GuestUser 'RaphaelBird@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: Login Expert user:RaphaelBird password:P@ssw0rd1 command "net use"') | Out-File $DIR
}
else{
echo "LOGIN FOR CLI1 NO user:RaphaelBird password:P@ssw0rd1" | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: Login Expert user:RaphaelBird password:P@ssw0rd1') | Out-File $DIR
}

echo "###############################################################'SRV1: Quota'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $SRV1 -ScriptText 'Get-FSRMQuota' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'SRV1: Quota command "Get-FSRMQuota"') | Out-File $DIR

echo "###############################################################'SRV1: File screen'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $SRV1 -ScriptText 'Get-FSRMFileScreen; out-file D:\shares\users\HilaryJimenez\test.txt; dir D:\shares\users\HilaryJimenez; out-file D:\shares\users\HilaryJimenez\app.exe; dir D:\shares\users\HilaryJimenez' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'SRV1: File screen command "Get-FSRMQuota"') | Out-File $DIR

echo "###############################################################'SRV1: Managers site'#########################################################################" | Out-File $DIR -Append -NoClobber
if (Invoke-VMScript -vm $CLI1 -ScriptText 'LOGIN YES' -GuestUser 'AidanByrd@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber){
Invoke-VMScript -vm $CLI1 -ScriptText 'Invoke-WebRequest -Uri http://managers.pest.com -UseBasicParsing' -GuestUser 'AidanByrd@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: Managers site open CL1 manager user:AidanByrd password:P@ssw0rd1 command "Invoke-WebRequest -Uri http://managers.pest.com -UseBasicParsing"') | Out-File $DIR
}
else{
echo "LOGIN FOR CLI1 NO user:AidanByrd password:P@ssw0rd1" | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: Managers site open CL1 manager user:AidanByrd password:P@ssw0rd1CLI1: Login Expert user:RaphaelBird password:P@ssw0rd1') | Out-File $DIR
}



echo "###############################################################'DCA: AD CS - installed'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DCA -ScriptText 'get-windowsfeature ad-certificate' -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DCA: AD CS - installed command "get-windowsfeature ad-certificate"') | Out-File $DIR

echo "###############################################################'DCA: AD CS - CS name'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DCA -ScriptText "certutil -dump 'C:\Windows\System32\CertSrv\CertEnroll\DCA.pest.com_pest CA.crt'" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DCA: AD CS - CS name command "get-windowsfeature ad-certificate"') | Out-File $DIR

echo "###############################################################'DCA: AD CS - CS Lifetime'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DCA -ScriptText "certutil -dump 'C:\Windows\System32\CertSrv\CertEnroll\DCA.pest.com_pest CA.crt'" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DCA: AD CS - CS Lifetime command "get-windowsfeature ad-certificate"') | Out-File $DIR

echo "###############################################################'DCA: AD CS - Templates'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DCA -ScriptText "certutil -template  ManUsers; certutil -template  ClientComps" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DCA: AD CS - Templates command "certutil -template  ManUsers; certutil -template  ClientComps"') | Out-File $DIR


echo "###############################################################'BRIDGE1: VPN server configured and tunnel is working'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC1 -ScriptText "ping buda.pest.com" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC1: BRIDGE1: VPN server configured and tunnel is working command "ping buda.pest.com"') | Out-File $DIR
Invoke-VMScript -vm $DC2 -ScriptText "ping pest.com" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC2: BRIDGE1: VPN server configured and tunnel is working command "ping pest.com"') | Out-File $DIR
Invoke-VMScript -vm $BRIDGE1 -ScriptText "get-vpnauthprotocol" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'BRIDGE1:VPN server configured and tunnel is working command "get-vpnauthprotocol"') | Out-File $DIR

echo "###############################################################'DC2: Buda.Pest.com subdomain'#########################################################################" | Out-File $DIR -Append -NoClobber
Invoke-VMScript -vm $DC2 -ScriptText "systeminfo" -GuestUser 'Administrator@Pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'DC2: Buda.Pest.com subdomain login in Administrator@Pest.com/P@ssw0rd command "systeminfo"') | Out-File $DIR

echo "###############################################################'DC2: Sleep mode'#########################################################################" | Out-File $DIR -Append -NoClobber
if(Invoke-VMScript -vm $CLI2 -ScriptText "echo SLEEPMODE DISABLE " -GuestUser 'Administrator@buda.pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell){
   Invoke-VMScript -vm $CLI2 -ScriptText " echo SLEEPMODE DISABLE " -GuestUser 'Administrator@buda.pest.com' -GuestPassword 'P@ssw0rd' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
    (Get-Content $DIR).replace('ScriptOutput', 'CLI2: Sleep mode check') | Out-File $DIR
    }
    else{
    echo "echo SLEEPMODE ENABLE" | Out-File $DIR -Append -NoClobber
    (Get-Content $DIR).replace('ScriptOutput', 'CLI2: Sleep mode check') | Out-File $DIR
    Start-VM -VM $CLI2 -Confirm:$false
    }
echo "###############################################################'SRV2: Web site only https www.Pest.com and www.buda.pest.com'#########################################################################" | Out-File $DIR -Append -NoClobber
if (Invoke-VMScript -vm $CLI1 -ScriptText 'LOGIN YES' -GuestUser 'DorothyCervantes@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber){
Invoke-VMScript -vm $CLI1 -ScriptText 'Invoke-WebRequest -Uri https://www.pest.com -UseBasicParsing' -GuestUser 'AidanByrd@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: web www.pest.com site open CL1 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.pest.com -UseBasicParsing"') | Out-File $DIR
}
else{
echo "LOGIN FOR CLI1 NO user:DorothyCervantes password:P@ssw0rd1" | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: web www.pest.com site open CL1 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.pest.com -UseBasicParsing"') | Out-File $DIR
}

if (Invoke-VMScript -vm $CLI2 -ScriptText 'LOGIN YES' -GuestUser 'DorothyCervantes@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber){
Invoke-VMScript -vm $CLI2 -ScriptText 'Invoke-WebRequest -Uri https://www.pest.com -UseBasicParsing' -GuestUser 'AidanByrd@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI2: web www.pest.com site open CL2 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.pest.com -UseBasicParsing"') | Out-File $DIR
}
else{
echo "LOGIN FOR CLI2 NO user:DorothyCervantes password:P@ssw0rd1" | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI2: web www.pest.com site open CL2 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.pest.com -UseBasicParsing"') | Out-File $DIR
}



if (Invoke-VMScript -vm $CLI1 -ScriptText 'LOGIN YES' -GuestUser 'DorothyCervantes@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber){
Invoke-VMScript -vm $CLI1 -ScriptText 'Invoke-WebRequest -Uri https://www.buda.pest.com -UseBasicParsing' -GuestUser 'AidanByrd@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: web www.buda.pest.com site open CL1 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.buda.pest.com -UseBasicParsing"') | Out-File $DIR
}
else{
echo "LOGIN FOR CLI1 NO user:DorothyCervantes password:P@ssw0rd1" | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI1: web www.buda.pest.com site open CL1 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.buda.pest.com -UseBasicParsing"') | Out-File $DIR
}

if (Invoke-VMScript -vm $CLI2 -ScriptText 'LOGIN YES' -GuestUser 'DorothyCervantes@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber){
Invoke-VMScript -vm $CLI2 -ScriptText 'Invoke-WebRequest -Uri https://www.pest.com -UseBasicParsing' -GuestUser 'AidanByrd@Pest.com' -GuestPassword 'P@ssw0rd1' -ScriptType Powershell | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI2: web www.buda.pest.com site open CL2 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.buda.pest.com -UseBasicParsing"') | Out-File $DIR
}
else{
echo "LOGIN FOR CLI2 NO user:DorothyCervantes password:P@ssw0rd1" | Out-File $DIR -Append -NoClobber
(Get-Content $DIR).replace('ScriptOutput', 'CLI2: web www.buda.pest.com site open CL2 user:DorothyCervantes password:P@ssw0rd1 command "Invoke-WebRequest -Uri https://www.buda.pest.com -UseBasicParsing"') | Out-File $DIR
}
