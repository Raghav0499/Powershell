Add-Type –Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll" 
Add-Type –Path "C:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll"

$AdminUrl = "https://tenant-admin.sharepoint.com/"
$UserName = "username@tenant.onmicrosoft.com"
$Password = "password"
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
$Credentials = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $SecurePassword

#Retrieve all site collection infos
Connect-SPOService -Url $AdminUrl -Credential $Credentials
$sites = Get-SPOSite 