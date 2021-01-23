 param 
   ( 
        [Parameter(Mandatory)]
        [String]$DomainName
        )


Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
$pass="Passw0rd"
$Pwd = $pass | ConvertTo-SecureString -AsPlainText -Force

Install-ADDSForest -DomainName $DomainName -SafeModeAdministratorPassword $Pwd -Confirm:$false -Force -InstallDns:$true -DomainNetbiosName TEST -NoRebootOnCompletion
Restart-computer

#Install-ADDSForest -DomainName "test.com" -DomainNetBiosName "TEST" -InstallDns:$true -NoRebootCompletion:$true
#Install-ADDSDomainController -DomainName "test.com" -InstallDns:$true -Credential (Get-Credential "test\administrator") 