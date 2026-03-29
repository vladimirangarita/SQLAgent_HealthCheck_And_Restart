# SQLAgent_HealthCheck_And_Restart
# 🛠️ SQL Agent Monitor & Auto-Recovery
**Solución de Monitoreo Proactivo y Autorrecuperación para SQL Server**

Este script de PowerShell está diseñado para administradores de bases de datos (DBA) y SysAdmins que gestionan múltiples instancias de SQL Server. Su función principal es garantizar la continuidad de los Jobs y tareas programadas mediante el monitoreo constante del servicio **SQL Server Agent** y su reinicio automático ante caídas inesperadas.

---

## 🚀 Funcionalidades Clave
* **Monitoreo Multi-Servidor:** Supervisión de una lista definida de servidores remotos desde un punto central.
* **Auto-Healing (Autorrecuperación):** Intento automático de inicio del servicio si se detecta con estado "Detenido".
* **Alertas SMTP de Prioridad Alta:** Envío inmediato de correos electrónicos con el resultado de la acción (Éxito o Fallo crítico).
* **Logging Mensual:** Generación automática de registros de auditoría (`.log`) organizados por mes para facilitar el análisis de causa raíz.

---

## 🛠️ Requisitos Técnicos
* **Windows PowerShell 5.1** o superior.
* **Permisos de Administrador:** El usuario que ejecuta el script debe tener permisos de gestión de servicios en los servidores remotos.
* **WinRM:** Debe estar habilitado para la gestión remota.
* **Servidor SMTP:** Acceso a un relay de correo para las notificaciones.

---

## 📂 Estructura del Proyecto
* `Monitor-SQLAgentService.ps1`: Script principal con la lógica de monitoreo.
* `C:\Scripts\Logs\`: Directorio de destino para los archivos de auditoría (creado automáticamente).

---

## ⚙️ Configuración Rápida
Para implementar este script en su entorno, edite las siguientes variables en el archivo `.ps1`:

```powershell
$Servidores = @("NombreServidor1", "NombreServidor2") # Sus servidores aquí
$SMTPServer = "192.168.1.X"                          # Su IP de SMTP
$Para = "soporte@empresa.com"                       # Destinatarios de alertas
