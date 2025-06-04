# Set certificate subject
$certSubject = "CN=KeepitAppCertificate"

# Create the certificate in CurrentUser\My store
$cert = New-SelfSignedCertificate -Subject $certSubject `
    -CertStoreLocation "Cert:\CurrentUser\My" `
    -KeyExportPolicy Exportable `
    -KeySpec Signature `
    -KeyLength 2048 `
    -NotAfter (Get-Date).AddYears(3) `
    -KeyAlgorithm RSA

# Check if the certificate was created
if ($cert -eq $null) {
    Write-Error "Certificate creation failed."
    return
}

# Set password for PFX export
$pwd = ConvertTo-SecureString -String "MykeepitBackpass@2025" -Force -AsPlainText

# Export certificate + private key (PFX)
Export-PfxCertificate -Cert $cert -FilePath "C:\KeepitCert.pfx" -Password $pwd

# Export public certificate only (CER)
Export-Certificate -Cert $cert -FilePath "C:\KeepitCert.cer"

-----------------------------------------------------------------------------------------------------------------------------

openssl pkcs12 -in /c/Users/YourName/Desktop/KeepitCert.pfx -nocerts -nodes -out /c/Users/YourName/Desktop/keepit-private-key.pem



















