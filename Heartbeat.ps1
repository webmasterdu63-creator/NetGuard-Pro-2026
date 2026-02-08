# --- NetGuard-Pro-2026 ---
# Unified Network Heartbeat Monitor
# ---------------------------------------

$Devices = @(
    @{ Name="Gateway"; IP="192.168.1.1" },
    @{ Name="Domain Controller"; IP="192.168.1.10" },
    @{ Name="File Server"; IP="192.168.1.20" },
    @{ Name="Web Server External"; IP="8.8.8.8" }
)

Write-Host "--- NetGuard-Pro-2026 : Monitoring Started ---" -ForegroundColor Cyan

foreach ($Device in $Devices) {
    $Status = Test-Connection -ComputerName $Device.IP -Count 1 -Quiet
    
    if ($Status) {
        Write-Host "[UP] $($Device.Name) ($($Device.IP)) is responding." -ForegroundColor Green
    } else {
        Write-Host "[DOWN] ALERT: $($Device.Name) ($($Device.IP)) IS OFFLINE!" -ForegroundColor Red -Bold
        # Optionnel : Envoyer un mail ou une notification ici
        # Send-MailMessage -To "admin@societe.com" -Subject "CRITICAL: $($Device.Name) Down"
    }
}

Write-Host "--- Scan Complete ---" -ForegroundColor Cyan
