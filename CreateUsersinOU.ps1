#Import the Active Directory Module 
Import-module activedirectory  
 
#Import the list from the user 
$Users = Import-Csv -Path C:\temp\Userlist.csv            
foreach ($User in $Users)             
{   $Office          
    $Displayname =  $User.Firstname + " " + $User.Lastname  
    $UserFirstname = $User.Firstname 
    $UserFirstIntial = $UserFirstname.Substring(1,1) 
    $Usermiddlename = $User.Middlename  
    $UserLastname = $User.Lastname             
    $OU = $User.OU 
    $SAM = $User.SAM        
    $UPN = $User.SAM + "@" + $User.Maildomain             
    $Description = $User.Description             
    $Password = $User.Password 
     
    #Creation of the account with the requested formatting. 
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -SamAccountName $SAM -Office "Office"  -UserPrincipalName $UPN -GivenName "$UserFirstname" -Surname "$UserLastname" -Description "$Description" -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) -Enabled $true -Path "$OU" -ChangePasswordAtLogon $false –PasswordNeverExpires $True -server contoso2016-1.contoso.com             
       $Displayname 
}