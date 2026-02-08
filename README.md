# 🛡️ NetGuard-Pro-2026 : Unified Network Infrastructure Monitoring
<p align="center">
  <img src="https://github.com/webmasterdu63-creator/NetGuard-Pro-2026/blob/main/NetGuardPro.jpg" width="200" alt="NetGuard Pro 2026 Logo">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Focus-Network%20Monitoring-blue" alt="Focus">
  <img src="https://img.shields.io/badge/Security-Enterprise%20Grade-red" alt="Security">
  <img src="https://img.shields.io/badge/Uptime-24%2F7-brightgreen" alt="Uptime">
</p>

## 🌐 Enterprise-Grade Oversight
**NetGuard-Pro-2026** is a professional-tier surveillance engine designed for **TSSR** and **SysAdmin** teams. It provides deep visibility into complex network topologies, ensuring 99.9% uptime through proactive node heartbeat tracking and real-time traffic heuristics.

## ✨ Core Precision Features
* **Node Heartbeat Monitoring**: High-frequency ICMP/SNMP polling for critical server clusters.
* **Intrusion Heuristics**: Detection of unauthorized packet spikes or suspicious lateral movements.
* **Dynamic Asset Mapping**: Automatic discovery and inventory of connected hardware within the subnet.
* **Incident Alerting**: Zero-latency notification system via Webhooks (Discord/Slack) or SMTP.
## 🚀 Quick Start
To run a manual network health check:
1. Open PowerShell as Administrator.
2. Navigate to `/scripts`.
3. Run: `./Heartbeat.ps1`

Web Dashboard: Generates a real-time HTML5/CSS3 status page with neon UI.
🕒 Pour l'automatisation (Niveau Expert TSSR)

Pour que ce dashboard soit toujours à jour , voici comment créer une Tâche Planifiée en une seule ligne 
de commande PowerShell (à lancer en Administrateur) :
$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-WindowStyle Hidden -File `"$PSScriptRoot\Dashboard.ps1`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "NetGuard_Heartbeat_Update" -Description "Mise à jour du Dashboard NetGuard toutes les 5 min"

## ⚙️ Automation & Deployment

To ensure **NetGuard-Pro-2026** runs as a 24/7 background service without manual intervention, follow these steps to set up a Windows Scheduled Task.

### 🕒 Automatic Background Updates
This configuration will trigger the `Dashboard.ps1` script every 5 minutes in silent mode (hidden window).

1. Open **PowerShell** as Administrator.
2. Run the following command to create the task:

```powershell
`$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-WindowStyle Hidden -File `"`$PSScriptRoot\Dashboard.ps1`""
`$trigger = New-ScheduledTaskTrigger -AtLogOn
`$trigger.RepetitionInterval = (New-TimeSpan -Minutes 5)
Register-ScheduledTask -Action `$action -Trigger `$trigger -TaskName "NetGuard_Heartbeat_Service" -User "SYSTEM" -RunLevel Highest
