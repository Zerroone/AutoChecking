#Скрипт сбора инициализационной информации для передачи скиптам автоматического сбора информации с хостов
#Подключаем модули для обработки графических форм
Add-Type -AssemblyName System.Windows.Forms
#Унаем дату отработки скрипта
$DATE = Get-Date -Format MM-dd-yyyy-HH-mm
#Создаем основную форму
$Form = New-Object System.Windows.Forms.Form
$Form.Text = 'Скрипт автопроверки пользователей'
$Form.StartPosition = 'CenterScreen'
$Form.Width = 1000
$Form.Height = 500
$Form.AutoSize = $true

#Создаем поля для заполнения количества стендов Linux
$LabelLN = New-Object System.Windows.Forms.Label
$LabelLN.Left = 10
$LabelLN.Top = 10
$LabelLN.Text = 'Введите количество проверяемых стендов Linux'
$LabelLN.AutoSize = $true

$InputLN = New-Object System.Windows.Forms.TextBox
$InputLN.Left = 350
$InputLN.Top = 10
$InputLN.Width = 25

#Создаем поля для заполнения количества стендов Windows
$LabelWN = New-Object System.Windows.Forms.Label
$LabelWN.Left = 510
$LabelWN.Top = 10
$LabelWN.Text = 'Введите количество проверяемых стендов Windows'
$LabelWN.AutoSize = $true

$InputWN = New-Object System.Windows.Forms.TextBox
$InputWN.Left = 870
$InputWN.Top = 10
$InputWN.Width = 25

#Создаем кнопку обработки значений количества стендов
$ButtonN = New-Object System.Windows.Forms.Button
$ButtonN.Text = 'Подтвердить'
$ButtonN.Top = 40
$ButtonN.Left = 10
$ButtonN.Width = 960
$regexip ='[\^?<>"\\/=|_()\:*\]\[qwertyuiopasdfghjklzxcvbnmёйцукенгшщзхъфывапролджэячсмитьбю]'
$linhostarr = New-Object System.Collections.ArrayList
$winhostarr = New-Object System.Collections.ArrayList
$linuserarr = New-Object System.Collections.ArrayList
$winuserarr = New-Object System.Collections.ArrayList
$ButtonN.Add_Click({
    if([regex]::IsMatch($InputLN.Text,$regexip)) {
        $error = New-Object -ComObject Wscript.Shell
        $output = $error.popup("Ошибка! Пожалуйста, укажите количество Linux стендов цифрой")
        $InputLN.Clear();
        }
    if([regex]::IsMatch($InputWN.Text,$regexip)) {
        $error = New-Object -ComObject Wscript.Shell
        $output = $error.popup("Ошибка! Пожалуйста, укажите количество Windows стендов цифрой")
        $InputWN.Clear();
        }
    else {
        for ($i=0;$i -lt [int]$InputLN.Text;$i++) {
            $jl = $i + 1
            $linlabel = New-Object System.Windows.Forms.Label
            $linlabel.Text = "Адрес Linux №$jl" + ":"
            $linlabel.AutoSize = $true
            $linlabel.Left = 10
            $linlabel.Top = 50 + $jl * 21
            $linhostarr.add((New-Object System.Windows.Forms.TextBox))
            $linhostarr[$i].Top = 50 + $jl * 21
            $linhostarr[$i].Left = 135
            $linuserlabel = New-Object System.Windows.Forms.Label
            $linuserlabel.Text = "Фамилия:"
            $linuserlabel.Autosize = $true
            $linuserlabel.Left = 240
            $linuserlabel.Top = 50 + $jl * 21
            $linuserarr.add((New-Object System.Windows.Forms.TextBox))
            $linuserarr[$i].Top = 50 + $jl * 21
            $linuserarr[$i].Left = 320
            $Form.Controls.Add($linlabel)
            $Form.Controls.Add($linhostarr[$i])
            $Form.Controls.Add($linuserlabel)
            $Form.Controls.Add($linuserarr[$i])
            }
        for ($i=0;$i -lt [int]$InputWN.Text;$i++) {
            $jw = $i + 1
            $winlabel = New-Object System.Windows.Forms.Label
            $winlabel.Text = "Адрес Windows №$jw" + ":"
            $winlabel.AutoSize = $true
            $winlabel.Left = 510
            $winlabel.Top = 50 + $jw * 21
            $winhostarr.add((New-Object System.Windows.Forms.TextBox))
            $winhostarr[$i].Top = 50 + $jw * 21
            $winhostarr[$i].Left = 655
            $winuserlabel = New-Object System.Windows.Forms.Label
            $winuserlabel.Text = "Фамилия:"
            $winuserlabel.Autosize = $true
            $winuserlabel.Left = 760
            $winuserlabel.Top = 50 + $jw * 21
            $winuserarr.add((New-Object System.Windows.Forms.TextBox))
            $winuserarr[$i].Top = 50 + $jw * 21
            $winuserarr[$i].Left = 840
            $Form.Controls.Add($winlabel)
            $Form.Controls.Add($winhostarr[$i])
            $Form.Controls.Add($winuserlabel)
            $Form.Controls.Add($winuserarr[$i])
            }
        }
        if ($jl -lt $jw) {
            $ButtonS = New-Object System.Windows.Forms.Button
            $ButtonS.Text = 'Подтвердить'
            $ButtonS.Top = 100 + $jw * 21
            $ButtonS.Left = 10
            $ButtonS.Width = 960
            $Form.Controls.Add($ButtonS)
            }
        else {
            $ButtonS = New-Object System.Windows.Forms.Button
            $ButtonS.Text = 'Начать проверку'
            $ButtonS.Top = 100 + $jl * 21
            $ButtonS.Left = 10
            $ButtonS.Width = 960
            $Form.Controls.Add($ButtonS)
            }
        $Form.Controls.Remove($ButtonN)

$ButtonS.Add_Click({
    $linhostarrfin = New-Object System.Collections.ArrayList
    $winhostarrfin = New-Object System.Collections.ArrayList
    $linuserarrfin = New-Object System.Collections.ArrayList
    $winuserarrfin = New-Object System.Collections.ArrayList
    if ($InputLN.Text -ne 0) {
        for ($i=0;$i -lt $InputLN.Text;$i++){
            $linhostarrfin.add("$i")
            $linhostarrfin[$i] = $linhostarr[$i].Text
            $linuserarrfin.add("$i")
            $linuserarrfin[$i] = $linuserarr[$i].Text
            }
        }
    if ($InputWN.Text -ne 0) {
        for ($i=0;$i -lt $InputWN.Text;$i++){
            $winhostarrfin.add("$i")
            $winhostarrfin[$i] = $winhostarr[$i].Text
            $winuserarrfin.add("$i")
            $winuserarrfin[$i] = $winuserarr[$i].Text
            }
        }
#Создаем чек-листы для каждого стенда
    if ($InputLN.Text -ne 0) {
        mkdir LinuxCheck -ErrorAction SilentlyContinue
        mkdir tmplin -ErrorAction SilentlyContinue
        foreach ($user in $linuserarrfin){
            $LinuxCheckList = "$user" + "_Linux_" + "$DATE"
            $FileLinPath = "$PSScriptRoot" + "\LinuxCheck\" + "$LinuxCheckList" + ".txt"
            New-Item $FileLinPath -ItemType File
            $FileLinPathArr = $FileLinPathArr + ,$FileLinPath
            copy-item ("$PSScriptRoot" + "\Demo2020LinuxTemplate.ps1") -Destination ".\tmplin\Demo2020LinuxTemplate$user.ps1"
        }
     if ($InputWN.Text -ne 0) {
        mkdir WindowsCheck -ErrorAction SilentlyContinue
        mkdir tmpwin -ErrorAction SilentlyContinue
        foreach ($user in $winuserarrfin){
            $WindowsCheckList = "$user" + "_Windows_" + "$DATE"
            $FileWinPath = "$PSScriptRoot" + "\WindowsCheck\" + "$WindowsCheckList" + ".txt"
            New-Item $FileWinPath -ItemType File
            $FileWinPathArr = $FileWinPathArr + ,$FileWinPath
            copy-item ("$PSScriptRoot" + "\Demo2020WindowsTemplate.ps1") -Destination ".\tmpwin\Demo2020WindowsTemplate$user.ps1"
        }  
        $scriptslin = Get-ChildItem .\tmplin
        $scriptswin = Get-ChildItem .\tmpwin
        $counter = -1
        foreach ($script in $scriptslin){
            $counter++
            powershell ".\tmplin\$script" -NAMELIN $linuserarrfin[$counter] -SERVERLIN $linhostarrfin[$counter] -LOGINSERVERLIN root -PASSSERVERLIN P@ssw0rd -DIR $FileLinPathArr[$counter] -DATA $DATE
            
            }
        $counter = -1
        foreach ($script in $scriptswin){
            $counter++
            powershell ".\tmpwin\$script" -NAMEWIN $winuserarrfin[$counter] -SERVERWIN $winhostarrfin[$counter] -LOGINSERVERWIN root -PASSSERVERWIN P@ssw0rd -DIR $FileWinPathArr[$counter] -DATA $DATE
            }
        $exit = New-Object -ComObject Wscript.Shell
        $output = $exit.popup("Все стенды успешно проверены. Вы можете увидеть чек-листы участников в директории $PSScriptRoot в папках LinuxCheck и WindowsCheck соответственно")         
        Remove-Item .\tmplin -Recurse -Force -Confirm:$false
        Remove-Item .\tmpwin -Recurse -Force -Confirm:$false
        Clear-Variable -Name * -Force -ErrorAction SilentlyContinue
    }
}
})
})

#Выводим все поля на форму
$Form.Controls.Add($LabelLN)
$Form.Controls.Add($InputLN)
$Form.Controls.Add($LabelWN)
$Form.Controls.Add($InputWN)
$Form.Controls.Add($ButtonN)

#Выводим форму
$Form.ShowDialog()


