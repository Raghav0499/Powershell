#Get credentials 
$O365CREDS = Get-Credential 
 
#Configuring Session 
$SESSION = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $O365CREDS -Authentication Basic -AllowRedirection 
 
#Import Exchange Online Session 
Import-PSSession $SESSION -DisableNameChecking -AllowClobber
 
#Connect to Exchange Online 
Connect-MsolService -Credential $O365CREDS 

$UserBatchCsv = "C:\Temp\Batch_1.csv"

$MigrationEndpoint = Get-MigrationEndpoint

New-MigrationBatch -Name "Batch_01" -CSVData ([System.IO.File]::ReadAllBytes($UserBatchCsv)) -SourceEndpoint $MigrationEndPoint.Identity -TargetDeliveryDomain "example.mail.onmicrosoft.com"

New-MigrationBatch -Name "Batch_01" -CSVData ([System.IO.File]::ReadAllBytes($UserBatchCsv)) -SourceEndpoint $MigrationEndPoint.Identity -TargetDeliveryDomain "example.mail.onmicrosoft.com" -AutoStart -AutoComplete
 
Start-MigrationBatch "Batch_01"