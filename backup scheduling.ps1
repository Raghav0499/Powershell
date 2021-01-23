Param ([Parameter(Mandatory=$true)]$cond)

 

    $timestamp = Get-Date -F MM-dd-yyyy-hh-mm-ss
    $datestamp = Get-Date -F MM-dd-yyyy
    $LogFile= "C:\Backup\"+"Backup_" + $timestamp + ".log"
    Start-Transcript -path $LogFile -append 

 

#Backup Source Path
$source="C:\Files\"
#Folder where all our backup is gonna stored.
$bPath = 'C:\Backup\'

 

$CurrentTime = get-date

 

Switch($cond){
    daily
    {
        #Folder where our Daily backup is gonna stored.
        $FolderPath = "C:\Backup\Daily\" + $datestamp
        $ParentFolder = "C:\Backup\Daily"
        $RetentionDate = $CurrentTime.adddays("-14")
        Write-Host "Daily run selected"
    }
    weekly
    {
        #Folder where our weekly backup is gonna stored.
        $FolderPath = "C:\Backup\Weekly\" + $datestamp
        $ParentFolder = "C:\Backup\Weekly"
        $RetentionDate = $CurrentTime.adddays("-35")
        Write-Host "Weekly run selected"
    }
    monthly
    {
        #Folder where our Monthly backup is gonna stored.
        $FolderPath = "C:\Backup\Monthly\" + $datestamp
        $ParentFolder = "C:\Backup\Monthly"
        $RetentionDate = $CurrentTime.adddays("-180")
        Write-Host "Monthly run selected"
    }
}

 

#Compress Backup folder
$folder = Get-WmiObject -Query "SELECT * FROM CIM_Directory WHERE Name='C:\\Backup'"
if(!$folder.Compressed)
    {
        $folder.Compress()
        Write-Host "Folder compressed successfully"
    }

 

# Copy data to appropriate folder
$StartDateTime = Get-Date -F MM-dd-yyyy-hh-mm-ss
Write-Host "Staring data copy at: " $StartDateTime

 

try
{
    Copy-Item -path $source\* -destination (New-Item -ItemType Directory -Path $ParentFolder -Name $datestamp.toString()) -Recurse -Force
}
catch
{ 
    Write-Host $_.Exception.Message
}
finally
{
    $EndDateTime = Get-Date -F MM-dd-yyyy-hh-mm-ss
    Write-Host "Finished data copy at: " $EndDateTime
}

 


# Removing old directories based on retention

 

Write-Host "Removing old folders and files"  
# Deleting folders and files beyond retention date
Get-Childitem $ParentFolder | Where-Object {$_.LastWriteTime -lt $RetentionDate} | Remove-Item

 

Stop-Transcript