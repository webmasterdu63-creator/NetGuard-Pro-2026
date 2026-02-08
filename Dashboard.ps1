# --- NetGuard-Pro-2026 : Automated Dashboard Generator ---
$ReportFile = "$PSScriptRoot\index.html"
$Devices = @(
    @{ Name="Gateway"; IP="192.168.1.1" },
    @{ Name="Domain Controller"; IP="192.168.1.10" },
    @{ Name="File Server"; IP="192.168.1.20" },
    @{ Name="Google DNS"; IP="8.8.8.8" }
)

# Début du HTML avec Auto-Refresh (60 secondes)
$HtmlHeader = @"
<html><head>
<meta charset='UTF-8'>
<meta http-equiv='refresh' content='60'>
<style>
body { background: #0b0e14; color: #00ffff; font-family: 'Segoe UI', sans-serif; text-align: center; margin: 0; padding: 20px; }
.grid { display: flex; justify-content: center; gap: 20px; flex-wrap: wrap; margin-top: 50px; }
.card { border: 2px solid #00ffff; padding: 20px; border-radius: 10px; box-shadow: 0 0 15px #00ffff; width: 220px; transition: 0.3s; }
.up { background: rgba(0, 255, 0, 0.1); border-color: #00ff00; color: #00ff00; box-shadow: 0 0 15px #00ff00; }
.down { background: rgba(255, 0, 0, 0.1); border-color: #ff0000; color: #ff0000; box-shadow: 0 0 15px #ff0000; }
h1 { text-shadow: 0 0 15px #00ffff; letter-spacing: 2px; }
.timestamp { margin-top: 40px; color: #555; font-size: 0.9em; }
</style></head><body>
<h1>🛡️ NETGUARD-PRO-2026 LIVE STATUS</h1>
<div class='grid'>
"@

$HtmlContent = ""

foreach ($Device in $Devices) {
    # Test de connexion rapide
    $Status = Test-Connection -ComputerName $Device.IP -Count 1 -Quiet
    $Class = if ($Status) { "up" } else { "down" }
    $Label = if ($Status) { "ONLINE" } else { "OFFLINE" }
    $Icon = if ($Status) { "✔" } else { "✘" }
    
    $HtmlContent += "<div class='card $Class'><h3>$($Device.Name)</h3><p>$($Device.IP)</p><h2 style='margin:0;'>$Icon</h2><strong>$Label</strong></div>"
}

$HtmlFooter = "</div><p class='timestamp'>Dernière mise à jour : $(Get-Date -Format 'HH:mm:ss') | Auto-refresh : 60s</p></body></html>"

# Écriture du fichier
$HtmlHeader + $HtmlContent + $HtmlFooter | Out-File $ReportFile -Encoding utf8
Write-Host "[OK] NetGuard Dashboard mis à jour à $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Green
