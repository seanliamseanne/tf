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



At line:14 char:28
+     [string]<mjx-container class="MathJax" jax="CHTML" style="font-si …
+                            ~~~~~~~~~~~~~~~
Unexpected token 'class="MathJax"' in expression or statement.

At line:14 char:13
+     [string]<mjx-container class="MathJax" jax="CHTML" style="font-si …
+             ~
Missing closing ')' in expression.

At line:36 char:3
+ "@
+   ~
Missing closing ')' in expression.

At line:39 char:384
+ … 35em; width: 323px;">You can't use 'macro parameter character #' in m …
+                                                                ~
Missing closing ')' in expression.

At line:40 char:138
+ … math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></m …
+               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Unexpected token 'MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.CertName) (no owner email)"' in expression or statement.

At line:41 char:5
+     }
+     ~
Unexpected token '}' in expression or statement.

At line:42 char:1
+ }
+ ~
Unexpected token '}' in expression or statement.












-------------------------------------------------------------------------------------------------------------------------------------


lt;#
.SYNOPSIS
    Identifies expiring certificates in Azure and notifies application owners.
.DESCRIPTION
    Checks for certificates expiring within 30, 14, and 7 days and sends notifications.
.NOTES
    Version: 1.0
    Author: Your Name
    Creation Date: [Date]
#&gt;

# Parameters
param (
    [string]<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D446 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D440 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D447 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D443 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D446 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D463 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c3D"></mjx-c></mjx-mo><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2033"></mjx-c></mjx-mo></mjx-texatom><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D462 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45A TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45D TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D463 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2E"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="2"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45A TEX-I"></mjx-c></mjx-mi><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2033"></mjx-c></mjx-mo></mjx-texatom><mjx-mo class="mjx-n"><mjx-c class="mjx-c2C"></mjx-c></mjx-mo><mjx-mo class="mjx-n" space="2"><mjx-c class="mjx-c5B"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D454 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c5D"></mjx-c></mjx-mo></mjx-math></mjx-container>FromEmail = "cert-alerts@yourdomain.com",
    [string]<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-merror data-mjx-error="You can't use 'macro parameter character #' in math mode"><mjx-mtext style="font-family: MJXZERO, serif;"><mjx-utext variant="-explicitFont" style="font-size: 85.2%; padding: 0.881em 0px 0.235em; width: 323px;">You can't use 'macro parameter character #' in math mode</mjx-utext></mjx-mtext></mjx-merror></mjx-math></mjx-container>subscriptions = Get-AzSubscription

# Thresholds for notifications (30, 14, and 7 days)
<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-merror data-mjx-error="You can't use 'macro parameter character #' in math mode"><mjx-mtext style="font-family: MJXZERO, serif;"><mjx-utext variant="-explicitFont" style="font-size: 85.2%; padding: 0.881em 0px 0.235em; width: 323px;">You can't use 'macro parameter character #' in math mode</mjx-utext></mjx-mtext></mjx-merror></mjx-math></mjx-container>expiringCerts = @()
<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-merror data-mjx-error="You can't use 'macro parameter character #' in math mode"><mjx-mtext style="font-family: MJXZERO, serif;"><mjx-utext variant="-explicitFont" style="font-size: 85.2%; padding: 0.881em 0px 0.235em; width: 323px;">You can't use 'macro parameter character #' in math mode</mjx-utext></mjx-mtext></mjx-merror></mjx-math></mjx-container>sub in <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-merror data-mjx-error="You can't use 'macro parameter character #' in math mode"><mjx-mtext style="font-family: MJXZERO, serif;"><mjx-utext variant="-explicitFont" style="font-size: 85.2%; padding: 0.881em 0px 0.235em; width: 323px;">You can't use 'macro parameter character #' in math mode</mjx-utext></mjx-mtext></mjx-merror></mjx-math></mjx-container>cert in $expiringCerts) {
    <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D462 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D457 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c3D"></mjx-c></mjx-mo><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2033"></mjx-c></mjx-mo></mjx-texatom><mjx-mo class="mjx-n"><mjx-c class="mjx-c5B"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D434 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D445 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D462 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D451 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c5D"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D436 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D453 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D438 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45D TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D454 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi></mjx-math></mjx-container>(<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2E"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="2"><mjx-c class="mjx-c1D437 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D447 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D438 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45D TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D437 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2033"></mjx-c></mjx-mo></mjx-texatom></mjx-math></mjx-container>body = @"
Dear Application Owner,

This is a notification that the following certificate will expire soon:

Certificate Name: <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.CertName)
<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.AppName ? "Application: <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.AppName)" : "Key Vault: <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.VaultName)")
Expiration Date: <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.ExpiryDate.ToString("yyyy-MM-dd"))
Days Until Expiration: <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.DaysToExpiry)

Please renew this certificate before the expiration date to avoid service disruption.

If you have any questions, please contact IT support.

Regards,
Certificate Management Team
"@

    # Send email to owner if email exists
    if (<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-merror data-mjx-error="You can't use 'macro parameter character #' in math mode"><mjx-mtext style="font-family: MJXZERO, serif;"><mjx-utext variant="-explicitFont" style="font-size: 85.2%; padding: 0.881em 0px 0.235em; width: 323px;">You can't use 'macro parameter character #' in math mode</mjx-utext></mjx-mtext></mjx-merror></mjx-math></mjx-container>(<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2E"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="2"><mjx-c class="mjx-c1D438 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45D TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D437 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2E"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="2"><mjx-c class="mjx-c1D447 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D446 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D454 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2033"></mjx-c></mjx-mo></mjx-texatom><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D440 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D440 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D451 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D451 TEX-I"></mjx-c></mjx-mi><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2033"></mjx-c></mjx-mo></mjx-texatom><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D437 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D448 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D459 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D438 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45D TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="4"><mjx-c class="mjx-c3A"></mjx-c></mjx-mo></mjx-math></mjx-container>(<mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2E"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="2"><mjx-c class="mjx-c1D437 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D447 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D438 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D465 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45D TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D443 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D459 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D454 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D464 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c210E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D453 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2E"></mjx-c></mjx-mo><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c2033"></mjx-c></mjx-mo></mjx-texatom><mjx-texatom texclass="ORD"><mjx-mo class="mjx-n"><mjx-c class="mjx-c40"></mjx-c></mjx-mo></mjx-texatom><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D446 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D451 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D440 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D459 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D440 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D460 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D454 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D439 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45A TEX-I"></mjx-c></mjx-mi></mjx-math></mjx-container>FromEmail -To <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D434 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D451 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45A TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45B TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D438 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45A TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44E TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D456 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D459 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D446 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D462 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D457 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi></mjx-math></mjx-container>subject -Body <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D44F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45C TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D451 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D466 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2212"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="3"><mjx-c class="mjx-c1D446 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45A TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D461 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45D TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D446 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D463 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D452 TEX-I"></mjx-c></mjx-mi><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi></mjx-math></mjx-container>SMTPServer
        Write-Output "Sent admin notification for <mjx-container class="MathJax" jax="CHTML" style="font-size: 117.4%;"><mjx-math class="MJX-TEX"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo></mjx-math></mjx-container>cert.CertName) (no owner email)"
    }
}

Write-Output "Certificate expiration notification process completed."


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Load WinSCP .NET assembly
Add-Type -Path "$env:USERPROFILE\Documents\WindowsPowerShell\Modules\WinSCP\5.21.5.0\lib\WinSCPnet.dll"

# ========== CONFIGURATION ==========

# SFTP credentials
$SftpHost = "ftp.pageroonline.com"
$SftpUsername = "your_username"
$SftpPassword = "your_password"
$RemoteFolder = "/invoices"
$LocalDownloadPath = "C:\Temp\SftpInvoices"

# Azure Blob Storage
$StorageAccountName = "yourstorageaccount"
$StorageContainerName = "invoices"
$StorageConnectionString = "DefaultEndpointsProtocol=https;AccountName=...;AccountKey=...;EndpointSuffix=core.windows.net"

# ========== SETUP ==========

# Create local download folder if it doesn't exist
if (-not (Test-Path $LocalDownloadPath)) {
    New-Item -ItemType Directory -Path $LocalDownloadPath | Out-Null
}

# ========== STEP 1: Connect to SFTP and Download Files ==========

$sessionOptions = New-Object WinSCP.SessionOptions -Property @{
    Protocol = [WinSCP.Protocol]::Sftp
    HostName = $SftpHost
    UserName = $SftpUsername
    Password = $SftpPassword
    PortNumber = 22
    SshHostKeyPolicy = "GiveUpSecurityAndAcceptAny"
}

$session = New-Object WinSCP.Session
try {
    $session.Open($sessionOptions)

    # List files
    $remoteFiles = $session.ListDirectory($RemoteFolder).Files | Where-Object { -not $_.IsDirectory }

    foreach ($file in $remoteFiles) {
        $remotePath = Join-Path $RemoteFolder $file.Name
        $localPath = Join-Path $LocalDownloadPath $file.Name

        # Download file
        Write-Output "Downloading $remotePath..."
        $session.GetFiles($remotePath, $localPath).Check()
    }

} finally {
    $session.Dispose()
}

# ========== STEP 2: Upload Files to Azure Blob Storage ==========

# Connect to Azure Storage
$ctx = New-AzStorageContext -ConnectionString $StorageConnectionString

# Upload each file
Get-ChildItem -Path $LocalDownloadPath -File | ForEach-Object {
    $filePath = $_.FullName
    $blobName = $_.Name

    Write-Output "Uploading $blobName to Azure..."
    Set-AzStorageBlobContent -File $filePath -Container $StorageContainerName -Blob $blobName -Context $ctx | Out-Null
}

Write-Output "✅ Done. Files transferred from SFTP to Azure Blob Storage."


=================================================================================================================================

#!/bin/bash

FTP_HOST='ftp.pageroonline.com'
FTP_USER='Signicat'
FTP_PASS='1UBujpi*'
FTP_REMOTE_DIR='/fromPagero/ftp.pageroonline.com'
LOCAL_DIR="/home/adminuser/pagero_invoices"

AZURE_STORAGE_ACCOUNT="sftpsftpstorageaccount"
AUTH_MODE='sas-token'
SAS_TOKEN='sp=rw&st=2025-06-12T17:00:42Z&se=2025-06-13T01:00:42Z&spr=https&sv=2024-11-04&sr=c&sig=Y4YkIVRICKW%2Flxn8l8fCZ14nLu9Zm3pScepLWpFZjP0%3D'

mkdir -p "LOCAL_DIR"

echo "[$(date)] Starting FTP download..."
echo "FTP_HOST=$FTP_HOST"
echo "FTP_USER=$FTP_USER"
echo "FTP_PASS=$FTPPASS"

echo "DEBUG - FTP_USER: $FTP_USER"
echo "DEBUG - FTP_PASS: $FTP_PASS"


printf "user %s %s\npassive\ncd %s\nmget *\nbye\n" \
"$FTP_USER" "$FTP_PASS" "FTP_REMOTE_DIR" "$LOCAL_DIR | ftp -inv "$FTP_HOST"

echo "[$(date)] FTP download complete."

echo "[$(date)] Local files:"

ls -lh "$LOCAL_DIR"

if [ "$(ls -A "$LOCAL_DIR")" ]; then

echo "[$(date)] Uploading to Azure Blob Storage..."
az storage blob upload-batch \
 --account-name "AZURE_STORAGE_ACCOUNT" \
 --destination "AZURE_BLOB_CONTAINER" \
 --source "LOCAL_DIR" \
 --sas-token "$SAS_TOKEN" \
 --output table
echo "[$(date)] Upload complete"
fi

========================================================================================================================================================================


- script: |
    sudo apt-get update -y
    sudo apt-get install -y sshpass

    mkdir -p "$(LOCAL_DIR)"

    BATCH_FILE=$(mktemp)
    echo "lcd $(LOCAL_DIR)" > $BATCH_FILE
    echo "cd /fromPagero/ftp.pageroonline.com" >> $BATCH_FILE
    echo "mget *" >> $BATCH_FILE
    echo "bye" >> $BATCH_FILE

    echo "Starting SFTP download..."
    sshpass -p "$(SFTP_PASS)" sftp -oBatchMode=no -b $BATCH_FILE "$(SFTP_USER)@ftp.pageroonline.com"

    echo "Downloaded files:"
    ls -lh "$(LOCAL_DIR)"

    echo "Uploading files to Azure Blob Storage..."
    az storage blob upload-batch \
      --account-name $(AZURE_STORAGE_ACCOUNT) \
      --destination $(AZURE_BLOB_CONTAINER) \
      --source "$(LOCAL_DIR)" \
      --sas-token "$(SAS_TOKEN)" \
      --overwrite

    echo "Upload complete."
  displayName: 'Download from Pagero SFTP and upload to Azure Blob Storage'




=========================================================================================================================================================================


trigger:
- main  # Change to your branch

variables:
- group: PageroSecrets   # Link the variable group here
- name: LOCAL_DIR
  value: $(Agent.BuildDirectory)/pagero_sync

pool:
  vmImage: 'ubuntu-latest'

steps:

- script: |
    echo "Installing sshpass..."
    sudo apt-get update -y
    sudo apt-get install -y sshpass

    echo "Creating local directory for downloads: $(LOCAL_DIR)"
    mkdir -p "$(LOCAL_DIR)"

    echo "Preparing batch commands for SFTP..."
    BATCH_FILE=$(mktemp)
    echo "lcd $(LOCAL_DIR)" > $BATCH_FILE
    echo "cd /fromPagero/ftp.pageroonline.com" >> $BATCH_FILE   # Change remote dir if needed
    echo "mget *" >> $BATCH_FILE
    echo "bye" >> $BATCH_FILE

    echo "Starting SFTP download..."
    sshpass -p "$(SFTP_PASS)" sftp -oBatchMode=no -b $BATCH_FILE "$(SFTP_USER)@ftp.pageroonline.com"

    echo "Removing batch file..."
    rm $BATCH_FILE

    echo "Downloaded files:"
    ls -lh "$(LOCAL_DIR)"

    echo "Uploading files to Azure Blob Storage..."
    az storage blob upload-batch \
      --account-name $(AZURE_STORAGE_ACCOUNT) \
      --destination $(AZURE_BLOB_CONTAINER) \
      --source "$(LOCAL_DIR)" \
      --sas-token "$(SAS_TOKEN)" \
      --overwrite

    echo "Upload complete!"

  displayName: 'Download from Pagero FTP and upload to Azure Blob Storage'


==========================================""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


#!/bin/bash

# === Configuration ===
SFTP_HOST='ftp.pageroonline.com'           # <-- Replace if needed
SFTP_USER='your_sftp_user'                 # <-- Replace
SFTP_PASS='your_sftp_password'             # <-- Replace

SFTP_REMOTE_DOWNLOAD_DIR='/from_pagero'    # Download FROM Pagero
SFTP_REMOTE_UPLOAD_DIR='/to_pagero'        # Upload TO Pagero

LOCAL_DOWNLOAD_DIR="$HOME/pagero_sync/from"
LOCAL_UPLOAD_DIR="$HOME/pagero_sync/to"

AZURE_STORAGE_ACCOUNT='yourstorageaccount'     # <-- Replace
AZURE_BLOB_CONTAINER='yourcontainer'           # <-- Replace
SAS_TOKEN='?sp=rw&st=2025-06-13T00:00:00Z&se=2025-06-14T00:00:00Z&spr=https&sv=2022-11-02&sr=c&sig=abc%2F123%2Bxyz'  # <-- Replace

# === Ensure directories exist ===
mkdir -p "$LOCAL_DOWNLOAD_DIR"
mkdir -p "$LOCAL_UPLOAD_DIR"

echo "[$(date)] Starting Pagero SFTP ↔ Azure sync..."

# === Ensure sshpass is installed ===
if ! command -v sshpass &> /dev/null; then
  echo "sshpass not found. Installing..."
  sudo apt-get update && sudo apt-get install -y sshpass
fi

# === 1. Download FROM Pagero and delete remote files ===
echo "[$(date)] Downloading files from Pagero..."
sshpass -p "$SFTP_PASS" sftp \
  -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
  -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
  -oStrictHostKeyChecking=no \
  "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DOWNLOAD_DIR
cd $SFTP_REMOTE_DOWNLOAD_DIR
mget *
rm *
bye
EOF

echo "[$(date)] Download from Pagero complete."

# === 2. Upload downloaded files to Azure ===
if [ -d "$LOCAL_DOWNLOAD_DIR" ] && [ -n "$(find "$LOCAL_DOWNLOAD_DIR" -type f -print -quit)" ]; then
  echo "[$(date)] Uploading files from Pagero to Azure..."
  az storage blob upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --destination "$AZURE_BLOB_CONTAINER" \
    --source "$LOCAL_DOWNLOAD_DIR" \
    --sas-token "$SAS_TOKEN" \
    --overwrite \
    --output table
else
  echo "[$(date)] No new files downloaded from Pagero."
fi

# === 3. Download files from Azure to upload TO Pagero ===
echo "[$(date)] Downloading files from Azure Blob Storage..."
az storage blob download-batch \
  --account-name "$AZURE_STORAGE_ACCOUNT" \
  --destination "$LOCAL_UPLOAD_DIR" \
  --source "$AZURE_BLOB_CONTAINER" \
  --sas-token "$SAS_TOKEN" \
  --output table

# === 4. Upload TO Pagero ===
if [ -d "$LOCAL_UPLOAD_DIR" ] && [ -n "$(find "$LOCAL_UPLOAD_DIR" -type f -print -quit)" ]; then
  echo "[$(date)] Uploading files to Pagero..."
  sshpass -p "$SFTP_PASS" sftp \
    -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
    -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
    -oStrictHostKeyChecking=no \
    "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_UPLOAD_DIR
cd $SFTP_REMOTE_UPLOAD_DIR
mput *
bye
EOF
else
  echo "[$(date)] No new files to upload to Pagero."
fi

echo "[$(date)] ✅ Sync complete."


===========================+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


#!/bin/bash

# === Configuration ===
SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='Signicat'               # <-- Replace
SFTP_PASS='your_sftp_password'           # <-- Replace

# Separate remote dirs for download and upload
SFTP_REMOTE_DOWNLOAD_DIR='/inbox'        # Download FROM here
SFTP_REMOTE_UPLOAD_DIR='/outbox'         # Upload TO here

# Separate local dirs for download and upload
LOCAL_DOWNLOAD_DIR="$HOME/pagero_sync/from_sftp"
LOCAL_UPLOAD_DIR="$HOME/pagero_sync/to_sftp"

AZURE_STORAGE_ACCOUNT='yourstorageaccount'        # <-- Replace
AZURE_BLOB_CONTAINER='yourcontainer'              # <-- Replace
SAS_TOKEN='?sp=rw&st=2025-06-13T00:00:00Z&se=2025-06-14T00:00:00Z&spr=https&sv=2022-11-02&sr=c&sig=abc%2F123%2Bxyz'  # <-- Replace

# === Create local directories ===
mkdir -p "$LOCAL_DOWNLOAD_DIR"
mkdir -p "$LOCAL_UPLOAD_DIR"

echo "[$(date)] Starting bidirectional SFTP ↔ Azure sync..."

# === Ensure sshpass is installed ===
if ! command -v sshpass &> /dev/null; then
  echo "sshpass not found. Installing..."
  sudo apt-get update && sudo apt-get install -y sshpass
fi

# === 1. Download files FROM SFTP server ===
echo "[$(date)] Downloading files from SFTP server ($SFTP_REMOTE_DOWNLOAD_DIR)..."
sshpass -p "$SFTP_PASS" sftp \
  -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
  -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
  -oStrictHostKeyChecking=no \
  "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DOWNLOAD_DIR
cd $SFTP_REMOTE_DOWNLOAD_DIR
mget *
bye
EOF

echo "[$(date)] Download complete. Local files:"
ls -lh "$LOCAL_DOWNLOAD_DIR"

# === 2. Upload downloaded files TO Azure Blob Storage ===
if [ "$(ls -A "$LOCAL_DOWNLOAD_DIR")" ]; then
  echo "[$(date)] Uploading downloaded files to Azure Blob Storage..."
  az storage blob upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --destination "$AZURE_BLOB_CONTAINER" \
    --source "$LOCAL_DOWNLOAD_DIR" \
    --sas-token "$SAS_TOKEN" \
    --overwrite \
    --output table
  echo "[$(date)] Azure upload complete."
else
  echo "[$(date)] No new files downloaded from SFTP to upload."
fi

# === 3. Download files FROM Azure Blob Storage for upload TO SFTP ===
echo "[$(date)] Downloading files from Azure Blob Storage to upload directory..."
az storage blob download-batch \
  --account-name "$AZURE_STORAGE_ACCOUNT" \
  --source "$AZURE_BLOB_CONTAINER" \
  --destination "$LOCAL_UPLOAD_DIR" \
  --sas-token "$SAS_TOKEN" \
  --output table

echo "[$(date)] Files downloaded from Azure for upload:"
ls -lh "$LOCAL_UPLOAD_DIR"

# === 4. Upload files TO SFTP server ===
if [ "$(ls -A "$LOCAL_UPLOAD_DIR")" ]; then
  echo "[$(date)] Uploading files to SFTP server ($SFTP_REMOTE_UPLOAD_DIR)..."
  sshpass -p "$SFTP_PASS" sftp \
    -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
    -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
    -oStrictHostKeyChecking=no \
    "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_UPLOAD_DIR
cd $SFTP_REMOTE_UPLOAD_DIR
mput *
bye
EOF
  echo "[$(date)] Upload to SFTP complete."
else
  echo "[$(date)] No new files to upload to SFTP."
fi

echo "[$(date)] Bidirectional sync complete."






============================================================================================================================================================================
============================================================================================================================================================================


#!/bin/bash

# === Configuration ===
SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='your_sftp_user'               # <-- Replace
SFTP_PASS='your_sftp_password'           # <-- Replace
SFTP_REMOTE_DIR='/inbox'                 # <-- Replace if needed

LOCAL_DIR="$HOME/pagero_sync"
LOCAL_AZURE_DOWNLOAD_DIR="$HOME/pagero_sync/from_azure"

AZURE_STORAGE_ACCOUNT='yourstorageaccount'     # <-- Replace
AZURE_BLOB_CONTAINER='yourcontainer'           # <-- Replace
SAS_TOKEN='?sp=rw&st=2025-06-13T00:00:00Z&se=2025-06-14T00:00:00Z&spr=https&sv=2022-11-02&sr=c&sig=abc%2F123%2Bxyz'  # <-- Replace

# === Ensure required directories exist ===
mkdir -p "$LOCAL_DIR"
mkdir -p "$LOCAL_AZURE_DOWNLOAD_DIR"

# === Get absolute paths ===
ABS_LOCAL_DIR=$(realpath "$LOCAL_DIR")
ABS_AZURE_DOWNLOAD_DIR=$(realpath "$LOCAL_AZURE_DOWNLOAD_DIR")

echo "[$(date)] 🔁 Starting Pagero ↔ Azure sync..."

# === Ensure sshpass is installed ===
if ! command -v sshpass &> /dev/null; then
  echo "Installing sshpass..."
  sudo apt-get update && sudo apt-get install -y sshpass
fi

# === 1. Download .xml FROM Pagero SFTP ===
echo "[$(date)] 📥 Checking for .xml files on Pagero..."

sshpass -p "$SFTP_PASS" sftp \
  -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
  -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
  -oStrictHostKeyChecking=no \
  "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $ABS_LOCAL_DIR
cd $SFTP_REMOTE_DIR
mget *.xml
bye
EOF

downloaded_xml_count=$(find "$ABS_LOCAL_DIR" -maxdepth 1 -name "*.xml" | wc -l)

if [ "$downloaded_xml_count" -eq 0 ]; then
  echo "[$(date)] ⚠️ No .xml files found or downloaded from Pagero."
else
  echo "[$(date)] ✅ Downloaded $downloaded_xml_count .xml file(s) from Pagero:"
  ls -lh "$ABS_LOCAL_DIR"/*.xml
fi

# === 2. Upload downloaded files to Azure Blob Storage ===
if [ "$downloaded_xml_count" -gt 0 ]; then
  echo "[$(date)] ⬆️ Uploading downloaded .xml files to Azure Blob..."
  az storage blob upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --destination "$AZURE_BLOB_CONTAINER" \
    --source "$ABS_LOCAL_DIR" \
    --pattern "*.xml" \
    --sas-token "$SAS_TOKEN" \
    --overwrite \
    --output table
else
  echo "[$(date)] ⏭️ Skipping upload to Azure (no new .xml files)."
fi

# === 3. Download blobs from Azure matching cli-2018-*.txt ===
echo "[$(date)] 📥 Downloading cli-2018-*.txt blobs from Azure..."

blobs=$(az storage blob list \
  --account-name "$AZURE_STORAGE_ACCOUNT" \
  --container-name "$AZURE_BLOB_CONTAINER" \
  --prefix "cli-2018-" \
  --sas-token "$SAS_TOKEN" \
  --query "[?ends_with(name, '.txt')].name" \
  --output tsv)

downloaded_blob_count=0

for blob in $blobs; do
  echo "Downloading blob: $blob"
  az storage blob download \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --container-name "$AZURE_BLOB_CONTAINER" \
    --name "$blob" \
    --file "$ABS_AZURE_DOWNLOAD_DIR/$(basename "$blob")" \
    --sas-token "$SAS_TOKEN" \
    --output none
  ((downloaded_blob_count++))
done

if [ "$downloaded_blob_count" -eq 0 ]; then
  echo "[$(date)] ⚠️ No cli-2018-*.txt blobs found to download."
else
  echo "[$(date)] ✅ Downloaded $downloaded_blob_count blob(s) from Azure."
  ls -lh "$ABS_AZURE_DOWNLOAD_DIR"
fi

# === 4. Upload Azure files back TO Pagero ===
if [ "$(find "$ABS_AZURE_DOWNLOAD_DIR" -type f -name 'cli-2018-*.txt' | wc -l)" -gt 0 ]; then
  echo "[$(date)] ⬆️ Uploading downloaded Azure blobs back to Pagero..."

  sshpass -p "$SFTP_PASS" sftp \
    -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
    -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
    -oStrictHostKeyChecking=no \
    "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $ABS_AZURE_DOWNLOAD_DIR
cd $SFTP_REMOTE_DIR
mput cli-2018-*.txt
bye
EOF

  echo "[$(date)] ✅ Upload to Pagero complete."
else
  echo "[$(date)] ⏭️ No files to upload to Pagero."
fi

echo "[$(date)] ✅ Full sync complete."

----------------=============================================--------$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$






#!/bin/bash

# === Configuration ===
SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='your_sftp_user'               # <-- Replace
SFTP_PASS='your_sftp_password'           # <-- Replace
SFTP_REMOTE_DIR='/inbox'                 # <-- Replace if needed

LOCAL_DIR="$HOME/pagero_sync"

AZURE_STORAGE_ACCOUNT='yourstorageaccount'
AZURE_BLOB_CONTAINER='yourcontainer'
SAS_TOKEN='?sp=rw&st=2025-06-13T00:00:00Z&se=2025-06-14T00:00:00Z&spr=https&sv=2022-11-02&sr=c&sig=abc%2F123%2Bxyz'  # <-- Replace

# === Create local directory ===
mkdir -p "$LOCAL_DIR"

echo "[$(date)] Starting SFTP download from $SFTP_HOST..."

# === Ensure sshpass is installed ===
if ! command -v sshpass &> /dev/null; then
  echo "sshpass not found. Installing..."
  sudo apt-get update && sudo apt-get install -y sshpass
fi

# === Run SFTP non-interactively ===
sshpass -p "$SFTP_PASS" sftp \
  -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
  -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
  -oStrictHostKeyChecking=no \
  "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DIR
cd $SFTP_REMOTE_DIR
mget *
bye
EOF

echo "[$(date)] SFTP download complete."
echo "[$(date)] Local files downloaded:"
ls -lh "$LOCAL_DIR"

# === Upload to Azure Storage ===
if [ "$(ls -A "$LOCAL_DIR")" ]; then
  echo "[$(date)] Uploading to Azure Blob Storage..."

  az storage blob upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --destination "$AZURE_BLOB_CONTAINER" \
    --source "$LOCAL_DIR" \
    --sas-token "$SAS_TOKEN" \
    --overwrite \
    --output table

  echo "[$(date)] Upload complete."
else
  echo "[$(date)] No files to upload."
fi


========================================================================================
========================================================================================
========================================================================================


#!/bin/bash

# === Configuration ===
SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='your_sftp_user'
SFTP_PASS='your_sftp_password'
SFTP_REMOTE_DIR='/inbox'
LOCAL_DIR="$HOME/pagero_sync"

AZURE_STORAGE_ACCOUNT='yourstorageaccount'
AZURE_BLOB_CONTAINER='yourcontainer'
SAS_TOKEN='?sp=rw&st=2025-06-13T00:00:00Z&se=2025-06-14T00:00:00Z&spr=https&sv=2022-11-02&sr=c&sig=abc%2F123%2Bxyz'

# === D365 API Auth ===
TENANT_ID='your-tenant-id'
CLIENT_ID='your-client-id'
CLIENT_SECRET='your-client-secret'
DYNAMICS_URL='https://yourenv.operations.dynamics.com'
DATA_PROJECT='YourDataProjectName'

# === Ensure tools are installed ===
for tool in sshpass curl jq azcopy; do
  if ! command -v $tool &> /dev/null; then
    echo "Missing $tool. Installing..."
    sudo apt-get update
    sudo apt-get install -y $tool
  fi
done

# === Prepare local dir ===
mkdir -p "$LOCAL_DIR"

echo "[$(date)] Downloading from Pagero SFTP..."

sshpass -p "$SFTP_PASS" sftp \
  -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
  -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
  -oStrictHostKeyChecking=no \
  "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DIR
cd $SFTP_REMOTE_DIR
mget *
bye
EOF

echo "[$(date)] Starting upload + Dynamics import..."

# === Get OAuth token from Azure AD ===
echo "Authenticating with Azure AD..."
ACCESS_TOKEN=$(curl -s -X POST -d "grant_type=client_credentials&client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&resource=$DYNAMICS_URL" \
  "https://login.microsoftonline.com/$TENANT_ID/oauth2/token" | jq -r .access_token)

if [[ -z "$ACCESS_TOKEN" || "$ACCESS_TOKEN" == "null" ]]; then
  echo "Failed to get access token"
  exit 1
fi

# === Process each file ===
for FILE in "$LOCAL_DIR"/*; do
  [ -f "$FILE" ] || continue
  FILE_NAME=$(basename "$FILE")
  echo "Processing: $FILE_NAME"

  # 1. Upload to Azure Blob (optional, in case you still use Azure Storage)
  echo "Uploading to Azure Blob..."
  azcopy copy "$FILE" "https://${AZURE_STORAGE_ACCOUNT}.blob.core.windows.net/${AZURE_BLOB_CONTAINER}/${FILE_NAME}${SAS_TOKEN}" --overwrite=true

  # 2. Get SAS URL from D365
  echo "Requesting SAS URL from Dynamics..."
  SAS_URL=$(curl -s -X POST "$DYNAMICS_URL/data/DataManagementDefinitionGroups/Microsoft.Dynamics.DataEntities.GetAzureWriteUrl" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"containerName\": \"$AZURE_BLOB_CONTAINER\", \"blobName\": \"$FILE_NAME\"}" | jq -r .UploadUrl)

  if [[ -z "$SAS_URL" || "$SAS_URL" == "null" ]]; then
    echo "Failed to get SAS upload URL for $FILE_NAME"
    continue
  fi

  # 3. Upload file directly to D365 SAS URL
  echo "Uploading $FILE_NAME to Dynamics..."
  curl -s -X PUT "$SAS_URL" \
    -H "x-ms-blob-type: BlockBlob" \
    --data-binary @"$FILE" > /dev/null

  # 4. Trigger import
  echo "Triggering import for $FILE_NAME..."
  curl -s -X POST "$DYNAMICS_URL/data/DataManagementDefinitionGroups/Microsoft.Dynamics.DataEntities.ExecuteImport" \
    -H "Authorization: Bearer $ACCESS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"definitionGroupId\": \"$DATA_PROJECT\"}" > /dev/null

  echo "✅ Done: $FILE_NAME"
done

echo "[$(date)] All files processed."

≈===========⁵/////////

{
  "definition": {
    "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
    "actions": {
      "Get_blob_content_using_path": {
        "type": "ApiConnection",
        "inputs": {
          "host": {
            "connection": {
              "name": "@parameters('$connections')['azureblob']['connectionId']"
            }
          },
          "method": "get",
          "path": "/datasets/default/files/@{triggerOutputs()?['headers']['x-ms-file-path-encoded']}/content",
          "queries": {
            "inferContentType": true
          }
        },
        "runAfter": {},
        "metadata": {
          "operationMetadataId": "getBlobContentPath"
        }
      },
      "Log_File_Details": {
        "type": "Compose",
        "inputs": {
          "filename": "@triggerOutputs()?['headers']['x-ms-file-name']",
          "path": "@triggerOutputs()?['headers']['x-ms-file-path']",
          "content": "@body('Get_blob_content_using_path')"
        },
        "runAfter": {
          "Get_blob_content_using_path": ["Succeeded"]
        }
      }
    },
    "triggers": {
      "When_a_blob_is_added_or_modified_(V2)": {
        "type": "ApiConnectionWebhook",
        "inputs": {
          "host": {
            "connection": {
              "name": "@parameters('$connections')['azureblob']['connectionId']"
            }
          },
          "method": "get",
          "path": "/datasets/default/triggers/OnUpdatedFile",
          "queries": {
            "folderId": "/<your-container-name>",
            "inferContentType": true
          }
        },
        "metadata": {
          "operationMetadataId": "blobTrigger"
        }
      }
    },
    "outputs": {}
  },
  "parameters": {
    "$connections": {
      "value": {
        "azureblob": {
          "connectionId": "/subscriptions/<your-subscription-id>/resourceGroups/<your-resource-group>/providers/Microsoft.Web/connections/azureblob",
          "connectionName": "azureblob",
          "id": "/subscriptions/<your-subscription-id>/providers/Microsoft.Web/locations/<region>/managedApis/azureblob"
        }
      }
    }
  }
}

@@@@@@@@@@@@@@@@@@@××@×@@@@@@@
@@@####@@@$$$$$$

{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "logicAppName": {
      "type": "string",
      "defaultValue": "BlobTriggerTestApp"
    },
    "storageAccountName": {
      "type": "string",
      "defaultValue": "sftpftpstorageaccount"
    },
    "containerName": {
      "type": "string",
      "defaultValue": "exflow"
    }
  },
  "resources": [
    {
      "type": "Microsoft.Logic/workflows",
      "apiVersion": "2019-05-01",
      "name": "[parameters('logicAppName')]",
      "location": "[resourceGroup().location]",
      "properties": {
        "definition": {
          "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#",
          "contentVersion": "1.0.0.0",
          "actions": {
            "Log_blob_name": {
              "runAfter": {},
              "type": "Compose",
              "inputs": "@triggerOutputs()?['headers']['x-ms-file-last-modified']"
            }
          },
          "triggers": {
            "When_a_blob_is_added_or_modified": {
              "type": "ApiConnection",
              "inputs": {
                "host": {
                  "connection": {
                    "name": "@parameters('$connections')['azureblob']['connectionId']"
                  }
                },
                "method": "get",
                "path": "/datasets/default/triggers/onupdatedfile",
                "queries": {
                  "folderId": "/[parameters('containerName')]"
                }
              },
              "splitOn": "@triggerBody()?['value']"
            }
          },
          "outputs": {}
        },
        "parameters": {
          "$connections": {
            "value": {
              "azureblob": {
                "connectionId": "[resourceId('Microsoft.Web/connections', 'azureblob')]",
                "connectionName": "azureblob",
                "id": "/subscriptions/<your-subscription-id>/providers/Microsoft.Web/locations/<your-location>/managedApis/azureblob"
              }
            }
          }
        }
      }
    }
  ]
}

////====/////////////////////////

Install-Module Microsoft.Graph -Scope CurrentUser
Connect-MgGraph -Scopes "Application.Read.All", "Directory.Read.All", "AuditLog.Read.All"

$apps = Get-MgApplication -All
$results = @()

foreach ($app in $apps) {
    $info = [PSCustomObject]@{
        DisplayName             = $app.DisplayName
        AppId                   = $app.AppId
        AppOwnerCount           = ($app.Owners.Count)
        RedirectURICount        = ($app.Web.RedirectUris.Count)
        ImplicitGrantEnabled    = ($app.Web.ImplicitGrantSettings.EnableAccessTokenIssuance -or $app.Web.ImplicitGrantSettings.EnableIdTokenIssuance)
        SecretCount             = ($app.PasswordCredentials.Count)
        NearestSecretExpiry     = ($app.PasswordCredentials | Sort-Object EndDateTime | Select-Object -First 1).EndDateTime
        CertCount               = ($app.KeyCredentials.Count)
        NearestCertExpiry       = ($app.KeyCredentials | Sort-Object EndDateTime | Select-Object -First 1).EndDateTime
        ApiPermissions          = ($app.RequiredResourceAccess | ForEach-Object {
                                        $_.ResourceAccess | ForEach-Object { $_.Type }
                                   }) -join ", "
    }

    $results += $info
}

# Output results
$results | Format-Table -AutoSize
$results | Export-Csv -Path ".\AppSecurityAudit.csv" -NoTypeInformation

$signins = Get-MgAuditLogSignIn -All | Where-Object {
    $_.AppDisplayName -in $apps.DisplayName
}

$signins | Select-Object AppDisplayName, UserDisplayName, IPAddress, CreatedDateTime, Status | Export-Csv .\AppSignIns.csv -NoTypeInformation


================================================================================----------------------------------------------------------**********************************************


# === SAFE CLEANUP ===
if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" && "$TEMP_DIR" != "/" ]]; then
  echo "[$(date)] Cleaning temp folder: $TEMP_DIR"
  find "$TEMP_DIR" -maxdepth 1 -type f -name '*.xml' -delete
else
  echo "[$(date)] ERROR: TEMP_DIR is invalid. Aborting cleanup!"
  exit 1
fi






====88888888888888888888888888888888888888888=================================================


#!/bin/bash

# === CONFIGURATION ===
SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='your_sftp_user'           # <-- Replace
SFTP_PASS='your_sftp_password'       # <-- Replace
SFTP_REMOTE_DIR='/inbox'             # <-- Replace if needed

LOCAL_DIR="$HOME/pagero_sync"
ARCHIVE_DIR="$LOCAL_DIR/archive"
LOG_FILE="$LOCAL_DIR/downloaded_files.log"
LIST_FILE="$LOCAL_DIR/remote_list.txt"

AZURE_STORAGE_ACCOUNT='yourstorageaccount'       # <-- Replace
AZURE_BLOB_CONTAINER='yourcontainer'             # <-- Replace
SAS_TOKEN='?sp=rw&st=2025-06-13T00:00:00Z&se=2025-06-14T00:00:00Z&spr=https&sv=2022-11-02&sr=c&sig=abc%2F123%2Bxyz'  # <-- Replace

echo "[$(date)] === STARTING SYNC SCRIPT ==="

# === SETUP ===
mkdir -p "$LOCAL_DIR"
mkdir -p "$ARCHIVE_DIR"
touch "$LOG_FILE"

# === CLEANUP: Move old XMLs to archive instead of deleting ===
echo "[$(date)] Archiving old XML files from $LOCAL_DIR to $ARCHIVE_DIR..."
find "$LOCAL_DIR" -maxdepth 1 -type f -name '*.xml' -exec mv {} "$ARCHIVE_DIR/" \;

# === FETCH REMOTE FILE LIST ===
echo "[$(date)] Fetching file list from SFTP..."
sshpass -p "$SFTP_PASS" sftp -oStrictHostKeyChecking=no "$SFTP_USER@$SFTP_HOST" <<EOF > "$LIST_FILE"
cd $SFTP_REMOTE_DIR
ls -1
bye
EOF

echo "[$(date)] File list retrieved. Checking for new files..."

# === DOWNLOAD ONLY NEW FILES ===
while read -r file; do
  [[ -z "$file" || "$file" != *.xml ]] && continue

  if grep -Fxq "$file" "$LOG_FILE"; then
    echo "[$(date)] Skipping (already downloaded): $file"
    continue
  fi

  echo "[$(date)] Attempting to download: $file"

  sshpass -p "$SFTP_PASS" sftp -oStrictHostKeyChecking=no "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DIR
cd $SFTP_REMOTE_DIR
get "$file"
bye
EOF

  # === LOG ONLY IF DOWNLOAD SUCCEEDS ===
  if [[ -f "$LOCAL_DIR/$file" ]]; then
    echo "$file" >> "$LOG_FILE"
    echo "[$(date)] ✅ Successfully downloaded and logged: $file"
  else
    echo "[$(date)] ❌ Download failed: $file (not logged)"
  fi

done < "$LIST_FILE"

# === UPLOAD DOWNLOADED FILES TO AZURE STORAGE ===
if ls "$LOCAL_DIR"/*.xml &>/dev/null; then
  echo "[$(date)] Uploading new files to Azure Blob Storage..."

  az storage blob upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --destination "$AZURE_BLOB_CONTAINER" \
    --source "$LOCAL_DIR" \
    --sas-token "$SAS_TOKEN" \
    --overwrite \
    --output table

  echo "[$(date)] ✅ Upload complete."

  # === ARCHIVE DOWNLOADED FILES AFTER UPLOAD ===
  echo "[$(date)] Archiving uploaded XML files to $ARCHIVE_DIR..."
  mv "$LOCAL_DIR"/*.xml "$ARCHIVE_DIR"/

else
  echo "[$(date)] ⚠️ No new XML files to upload."
fi

echo "[$(date)] === SCRIPT FINISHED ==="




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" full script try ================================================================================================



#!/bin/bash

# === Configuration ===
SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='your_sftp_user'             # <-- Replace
SFTP_PASS='your_sftp_password'         # <-- Replace
SFTP_REMOTE_DIR='/inbox'               # <-- Replace if needed

LOCAL_DIR="$HOME/pagero_sync"
LOG_FILE="$LOCAL_DIR/downloaded_files.log"
REMOTE_LIST="$LOCAL_DIR/remote_files.txt"

AZURE_STORAGE_ACCOUNT='yourstorageaccount'               # <-- Replace
AZURE_BLOB_CONTAINER='yourcontainer'                     # <-- Replace
SAS_TOKEN='?sp=rw&st=2025-06-13T00:00:00Z&se=2025-06-14T00:00:00Z&spr=https&sv=2022-11-02&sr=c&sig=abc%2F123%2Bxyz'  # <-- Replace

# === Setup local directory and log ===
mkdir -p "$LOCAL_DIR"
touch "$LOG_FILE"

echo "[$(date)] Starting sync..."

# === List files on the remote SFTP server ===
echo "[$(date)] Listing remote files..."
sshpass -p "$SFTP_PASS" sftp -oBatchMode=no -oStrictHostKeyChecking=no "$SFTP_USER@$SFTP_HOST" <<EOF > "$REMOTE_LIST"
cd $SFTP_REMOTE_DIR
ls
bye
EOF

# === Download new XML files only ===
echo "[$(date)] Checking for new XML files to download..."
while read -r file; do
  # Ignore blank lines and non-XML files
  [[ -z "$file" || "$file" != *.xml ]] && continue

  # Skip if already downloaded
  if grep -Fxq "$file" "$LOG_FILE"; then
    echo "[$(date)] Skipping already downloaded: $file"
    continue
  fi

  echo "[$(date)] Downloading: $file"
  sshpass -p "$SFTP_PASS" sftp -oStrictHostKeyChecking=no "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DIR
cd $SFTP_REMOTE_DIR
get $file
bye
EOF

  # Log the successful download
  if [[ -f "$LOCAL_DIR/$file" ]]; then
    echo "$file" >> "$LOG_FILE"
    echo "[$(date)] Successfully downloaded and logged: $file"
  else
    echo "[$(date)] ERROR: Failed to download $file"
  fi

done < "$REMOTE_LIST"

# === Upload to Azure Blob Storage ===
if compgen -G "$LOCAL_DIR/*.xml" > /dev/null; then
  echo "[$(date)] Uploading files to Azure Blob Storage..."
  az storage blob upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --destination "$AZURE_BLOB_CONTAINER" \
    --source "$LOCAL_DIR" \
    --sas-token "$SAS_TOKEN" \
    --overwrite \
    --output table

  echo "[$(date)] Upload complete."
else
  echo "[$(date)] No XML files to upload."
fi

echo "[$(date)] Script complete. Local archive: $LOCAL_DIR"


================================================================================================
=============================================


set -x

LOG_FILE="$HOME/pagero_sync_upload.log"
exec > >(tee -a "LOG_FILE") 2>&1

echo "[$(date)] script started"

SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='Signicat'
SFTP_PASS='1UBujpi*Pumr'
SFTP_REMOTE_DIR='/fromPagero/*'
SFTP_REMOTE_DIR='/toPagero/*'

LOCAL_DIR="/tmp/pagero_sync/"

AZURE_STORAGE_ACCOUNT='sftpsftpstorageaccount'
AZURE_BLOB_CONTAINER='exflow'
SAS_TOKEN='sv=2024-11-04&ss=bfqt&srt=co&sp=rwdlacupyx&se=2026-07-13T22:21:13Z&st=2025-06-16T14:21:13Z&spr=https&sig=fymu4Sw7MSSjbuOTH08IlbtrkSUr4wkP9LsHhmG2UeI%3D' 

echo "[$(date)] Creating local directory: $LOCAL_DIR"

mkdir -p "$LOCAL_DIR"
mkdir -p "$ARCHIVE_DIR"
touch "$LOG_FILE"

echo "[$(date)] Archiving old XML files from $LOCAL_DIR to $ARCHIVE_DIR..."
find "$LOCAL_DIR" -maxdepth 1 -type f -name '*.xml' -exec mv {} "$ARCHIVE_DIR/" \;

echo "[$(date)] Starting SFTP download from $SFTP_HOST..."

if ! command -v sshpass &> /dev/null; then
echo "sshpass not found. Installing..."
sudo apt-get update && sudo apt-get install -y sshpass
fi

LATEST_DATE=$(date +%Y%m%d)
sshpass -p "$SFTP_PASS" sftp \
-oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
-oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
-oStrictHostKeyChecking=no \
"$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DIR
cd $SFTP_REMOTE_DIR
mget -p *
bye
EOF


echo "[$(date)] File list retrieved. Checking for new files..."

while read -r file; do
[[ -z "$file" || "$file" != *.xml ]] && continue
if grep -Fxq "$file" "$LOG_FILE"; then
echo "[$(date)] Skipping (already downloaded): $file"
continue
fi

done < "$LIST_FILE"


echo "[$(date)] SFTP download complete."
echo "[$(date)] Local files downloaded:"
ls -lh "$LOCAL_DIR"

TEMP_DIR="$LOCAL_DIR/fromPagero/invoice/temp"
PROD_DIR="$LOCAL_DIR/fromPagero/invoice/prod"
TEST_DIR="$LOCAL_DIR/fromPagero/invoice/test"

mkdir -p "$TEMP_DIR" "$PROD_DIR" "$TEST_DIR"

echo "[$(date)] Moving files from temp to prod/test..."
find "$LOCAL_DIR" -maxdepth 1 -type f -name "*xml" -exec mv {} "$TEMP_DIR/" \;

for file in "$TEMP_DIR"/*; do
if [[ -f "$file" ]]; then
filename=$(basename "$file")
if [[ "$filename" == *prod.xml ]]; then
mv "$file" "$PROD_DIR/"
echo "Moved $filename to prod/"
else
mv "$file" "TEST_DIR/"
echo "Moved $filename to test/"
fi
fi
done

echo "[$(date) Current file structure:"
if command -v tree &> /dev/null; then
tree "$LOCAL_DIR"
else

find "$LOCAL_DIR"
fi

UPLOAD_ROOT="$LOCAL_DIR/fromPagero"

if [ "$(find "$UPLOAD_ROOT" -type f | wc -l)" -gt 0 ]; then
echo "[$(date)] Uploading to Azure Blob Storage from $UPLOAD_ROOT..."


echo "[$(date)] Uploading to Azure Blob Storage..."
az storage blob upload-batch \
 --account-name "$AZURE_STORAGE_ACCOUNT" \
 --destination "$AZURE_BLOB_CONTAINER" \
 --source "$LOCAL_DIR" \
 --sas-token "$SAS_TOKEN" \
 --overwrite  \
 --output table

echo "[$(date)] Upload complete."

else

echo "[$(date)] No files to upload."
fi

echo "[$(date)] script finished"



=--=-=-=-=-=new script ===--=-=-00-

#!/bin/bash
set -x

# === Logging ===
LOG_FILE="$HOME/pagero_sync_upload.log"
exec > >(tee -a "$LOG_FILE") 2>&1
echo "[$(date)] Script started"

# === Configuration ===
SFTP_HOST='ftp.pageroonline.com'
SFTP_USER='Signicat'
SFTP_PASS='1UBujpi*Pumr'

SFTP_FROM_DIR='/fromPagero'
SFTP_TO_DIR='/toPagero'

LOCAL_DIR="/tmp/pagero_sync"
ARCHIVE_DIR="$LOCAL_DIR/archive"
LIST_FILE="$LOCAL_DIR/remote_files.txt"
TO_UPLOAD_DIR="$LOCAL_DIR/toPagero_outbox"

AZURE_STORAGE_ACCOUNT='sftpsftpstorageaccount'
AZURE_BLOB_CONTAINER='exflow'
SAS_TOKEN='sv=2024-11-04&ss=bfqt&srt=co&sp=rwdlacupyx&se=2026-07-13T22:21:13Z&st=2025-06-16T14:21:13Z&spr=https&sig=fymu4Sw7MSSjbuOTH08IlbtrkSUr4wkP9LsHhmG2UeI%3D'

# === Setup folders ===
mkdir -p "$LOCAL_DIR" "$ARCHIVE_DIR" "$TO_UPLOAD_DIR"
touch "$LOG_FILE"

# === Archive old .xml files ===
echo "[$(date)] Archiving old XML files..."
find "$LOCAL_DIR" -maxdepth 1 -type f -name '*.xml' -exec mv {} "$ARCHIVE_DIR/" \;

# === Ensure sshpass ===
if ! command -v sshpass &> /dev/null; then
  echo "sshpass not found. Installing..."
  sudo apt-get update && sudo apt-get install -y sshpass
fi

# === List files from /fromPagero ===
echo "[$(date)] Listing files on SFTP /fromPagero..."
sshpass -p "$SFTP_PASS" sftp \
  -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
  -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
  -oStrictHostKeyChecking=no \
  "$SFTP_USER@$SFTP_HOST" <<EOF > "$LIST_FILE"
cd $SFTP_FROM_DIR
ls
bye
EOF

# === Download only new XML files from /fromPagero ===
echo "[$(date)] Downloading new XML files from /fromPagero..."
while read -r file; do
  [[ -z "$file" || "$file" != *.xml ]] && continue

  if grep -Fxq "$file" "$LOG_FILE"; then
    echo "[$(date)] Skipping already downloaded: $file"
    continue
  fi

  echo "[$(date)] Downloading $file..."
  sshpass -p "$SFTP_PASS" sftp \
    -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
    -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
    -oStrictHostKeyChecking=no \
    "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $LOCAL_DIR
cd $SFTP_FROM_DIR
get $file
bye
EOF

  if [[ -f "$LOCAL_DIR/$file" ]]; then
    echo "$file" >> "$LOG_FILE"
    echo "[$(date)] Successfully downloaded: $file"
  else
    echo "[$(date)] ERROR: Failed to download $file"
  fi
done < "$LIST_FILE"

# === Organize downloaded files ===
TEMP_DIR="$LOCAL_DIR/fromPagero/invoice/temp"
PROD_DIR="$LOCAL_DIR/fromPagero/invoice/prod"
TEST_DIR="$LOCAL_DIR/fromPagero/invoice/test"

mkdir -p "$TEMP_DIR" "$PROD_DIR" "$TEST_DIR"

echo "[$(date)] Moving files to temp dir..."
find "$LOCAL_DIR" -maxdepth 1 -type f -name "*.xml" -exec mv {} "$TEMP_DIR/" \;

echo "[$(date)] Sorting temp files to prod/test..."
for file in "$TEMP_DIR"/*; do
  if [[ -f "$file" ]]; then
    filename=$(basename "$file")
    if [[ "$filename" == *prod.xml ]]; then
      mv "$file" "$PROD_DIR/"
      echo "Moved $filename to prod/"
    else
      mv "$file" "$TEST_DIR/"
      echo "Moved $filename to test/"
    fi
  fi
done

# === Show current structure ===
echo "[$(date)] Current directory tree:"
if command -v tree &> /dev/null; then
  tree "$LOCAL_DIR"
else
  find "$LOCAL_DIR"
fi

# === Upload downloaded files to Azure ===
UPLOAD_ROOT="$LOCAL_DIR/fromPagero"
if [ "$(find "$UPLOAD_ROOT" -type f -name '*.xml' | wc -l)" -gt 0 ]; then
  echo "[$(date)] Uploading downloaded files to Azure Blob Storage..."
  az storage blob upload-batch \
    --account-name "$AZURE_STORAGE_ACCOUNT" \
    --destination "$AZURE_BLOB_CONTAINER" \
    --source "$UPLOAD_ROOT" \
    --sas-token "$SAS_TOKEN" \
    --overwrite \
    --output table
  echo "[$(date)] Azure upload complete."
else
  echo "[$(date)] No files to upload to Azure."
fi

# === Upload files to /toPagero on SFTP ===
if compgen -G "$TO_UPLOAD_DIR/*.xml" > /dev/null; then
  echo "[$(date)] Uploading new files to /toPagero on SFTP..."
  sshpass -p "$SFTP_PASS" sftp \
    -oHostKeyAlgorithms=+ssh-rsa,ssh-dss \
    -oPubkeyAcceptedKeyTypes=+ssh-rsa,ssh-dss \
    -oStrictHostKeyChecking=no \
    "$SFTP_USER@$SFTP_HOST" <<EOF
lcd $TO_UPLOAD_DIR
cd $SFTP_TO_DIR
mput *.xml
bye
EOF
  echo "[$(date)] Files uploaded to Pagero SFTP /toPagero."
else
  echo "[$(date)] No files found in $TO_UPLOAD_DIR to upload to Pagero."
fi

echo "[$(date)] Script finished."
























