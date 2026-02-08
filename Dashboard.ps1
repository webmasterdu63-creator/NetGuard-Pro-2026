# --- NetGuard-Pro-2026 : Dashboard Generator ---
$ReportFile = "$PSScriptRoot\index.html"
$Devices = @(
    @{ Name="Gateway"; IP="192.168.1.1" },
    @{ Name="Domain Controller"; IP="192.168.1.10" },
    @{ Name="File Server"; IP="192.168.1.20" },
    @{ Name="Google DNS"; IP="8.8.8.8" }
)

# Début du HTML
$HtmlHeader = @"
<html><head><meta charset='UTF-8'><style>
body { background: #0b0e14; color: #00ffff; font-family: 'Segoe UI', sans-serif; text-align: center; }
.grid { display: flex; justify-content: center; gap: 20px; margin-top: 50px; }
.card { border: 2px solid #00ffff; padding: 20px; border-radius: 10px; box-shadow: 0 0 15px #00ffff; width: 200px; }
.up { background: rgba(0, 255, 0, 0.1); border-color: #00ff00; color: #00ff00; box-shadow: 0 0 15px #00ff00; }
.down { background: rgba(255, 0, 0, 0.1); border-color: #ff0000; color: #ff0000; box-shadow: 0 0 15px #ff0000; }
h1 { text-shadow: 0 0 10px #00ffff; }
</style></head><body>
<h1>🛡️ NetGuard-Pro-2026 : Live Status</h1>
<div class='grid'>
"@

$HtmlContent = ""

foreach ($Device in $Devices) {
    $Status = Test-Connection -ComputerName $Device.IP -Count 1 -Quiet
    $Class = if ($Status) { "up" } else { "down" }
    $Label = if ($Status) { "ONLINE" } else { "OFFLINE" }
    
    $HtmlContent += "<div class='card $Class'><h3>$($Device.Name)</h3><p>$($Device.IP)</p><strong>$Label</strong></div>"
}

$HtmlFooter = "</div><p style='margin-top:50px;'>Last Update: $(Get-Date)</p></body></html>"

# Génération du fichier
$HtmlHeader + $HtmlContent + $HtmlFooter | Out-File $ReportFile
Write-Host "[OK] Dashboard généré : $ReportFile" -ForegroundColor Green
