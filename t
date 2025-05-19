
# === CONFIGURATION ===
$certName = "CN=Keepit-M365-Backup"
$friendlyName = "Keepit M365 Backup Cert"
$yearsValid = 2
$pfxPasswordPlain = "StrongKeepitBackP@ss!@2025"  # CHANGE THIS to something secure

# === PATHS ===
$desktopPath = [Environment]::GetFolderPath("Desktop")
$pfxPath = Join-Path $desktopPath "KeepitM365Backup.pfx"
$cerPath = Join-Path $desktopPath "KeepitM365Backup.cer"

# === Create Self-Signed Certificate ===
Write-Output "Creating self-signed certificate..."
$cert = New-SelfSignedCertificate -CertStoreLocation "Cert:\CurrentUser\My" `
    -Subject $certName `
    -KeySpec KeyExchange `
    -KeyExportPolicy Exportable `
    -KeyLength 2048 `
    -NotAfter (Get-Date).AddYears($yearsValid) `
    -FriendlyName $friendlyName

# === Export PFX (Private Key) ===
$password = ConvertTo-SecureString -String $pfxPasswordPlain -Force -AsPlainText
Write-Output "Exporting .pfx to: $pfxPath"
Export-PfxCertificate -Cert $cert -FilePath $pfxPath -Password $password | Out-Null

# === Export CER (Public Key) ===
Write-Output "Exporting .cer to: $cerPath"
Export-Certificate -Cert $cert -FilePath $cerPath | Out-Null

# === Display Summary ===
Write-Output "`n✅ DONE!"
Write-Output "Thumbprint: $($cert.Thumbprint)"
Write-Output "PFX File: $pfxPath"
Write-Output "CER File: $cerPath"
Write-Output "PFX Password: $pfxPasswordPlain"
