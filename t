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















































