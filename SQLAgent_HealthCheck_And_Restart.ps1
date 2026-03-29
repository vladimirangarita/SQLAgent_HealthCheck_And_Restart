# 1. Configuración de Servidores y Correo
$LogPath = "C:\Scripts\Logs\SQL_Agent_Monitor_$(Get-Date -Format 'yyyyMM').log" # Crea un log nuevo cada mes
$Servidores = @("Servidor1", "Servidor2", "Servidor3") # Añade aquí los nombres de tus servidores
$SMTPServer = "IP SMTP" 
$De = "Direccion de Correo"
$Para = "correo1@correo.com", "Correo2@correo.com"
$AsuntoBase = "ALERTA: Estado de SQL Agent en "

# Asegurar que la carpeta de Logs existe
if (!(Test-Path "C:\Scripts\Logs")) { New-Item -ItemType Directory -Path "C:\Scripts\Logs" }

foreach ($Server in $Servidores) {
 $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
 try {
 $Service = Get-Service -ComputerName $Server -Name "SQLServerAgent" -ErrorAction Stop

 if ($Service.Status -ne 'Running') {
 # Registrar evento en el LOG
 "$TimeStamp - ALERTA: SQL Agent en $Server detenido ($($Service.Status)). Intentando iniciar..." | Out-File -FilePath $LogPath -Append
 
 Start-Service -InputObject $Service
 Start-Sleep -Seconds 5
 $Service.Refresh()

 if ($Service.Status -eq 'Running') {
 "$TimeStamp - EXITO: Servicio levantado en $Server." | Out-File -FilePath $LogPath -Append
 $StatusMsg = "REESTABLECIDO"
 } else {
 "$TimeStamp - ERROR: No se pudo levantar el servicio en $Server." | Out-File -FilePath $LogPath -Append
 $StatusMsg = "FALLIDO (Revision manual requerida)"
 }

 # Enviar Correo
 $Cuerpo = "Servidor: $Server `Estado detectado: Detenido Accion: Reinicio automatico Resultado: $StatusMsg Fecha: $TimeStamp"
 Send-MailMessage -SmtpServer $SMTPServer -From $De -To $Para -Subject "SQL Agent Alert: $Server ($StatusMsg)" -Body $Cuerpo -Priority High
 }
 }
 catch {
 "$TimeStamp - CRITICO: No hay conexionn con $Server o servicio no encontrado." | Out-File -FilePath $LogPath -Append
 }
}
