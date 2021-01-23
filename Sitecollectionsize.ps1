Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
 
$sc = Get-SPSite http://spsvr:90
$sc.Usage.Storage