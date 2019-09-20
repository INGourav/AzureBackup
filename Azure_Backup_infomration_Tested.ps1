<#
I'm trying to list all the protected VMS and the last backup date
We can use PowerShell to list VMs in the recovery service vault and the latest recovery point, like this:
#>


#This line is used to set service vault context
Get-AzureRmRecoveryServicesVault -Name "Vault Name" -ResourceGroupName "Vault ResourceGroup Name" | Set-AzureRmRecoveryServicesVaultContext

#Storing Container Name in Variable
$nameContainer = Get-AzureRmRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -FriendlyName "VM Name"

#Cookig down script and retrieving data
Get-AzureRmRecoveryServicesBackupItem -Container $nameContainer -WorkloadType "AzureVM" | select @{ Name = 'AzVM Name'; Expression = {$_.ContainerName.Split(';')[-1]} },LatestRecoveryPoint

#We can also select {ProtectionStatus, ProtectionState, LastBackupTime, LatestRecoveryPoint}
#if want to export result add " | export-csv C:\temp\testbackup.csv -NoTypeInformation -Append" 
#E.G:-
#Get-AzureRmRecoveryServicesBackupItem -Container $nameContainer -WorkloadType "AzureVM" | select @{ n = 'AzVM Name'; e = {$_.ContainerName.Split(';')[-1]} },LatestRecoveryPoint | export-csv C:\temp\testbackup.csv -NoTypeInformation -Append



*****************************************************************************************


#If we have many VMs, we can use Foreach to list Azure VM Name and LatestRecoveryPoint, we can use this script:


Get-AzureRmRecoveryServicesVault -Name "Vault Name" -ResourceGroupName "Vault ResourceGroup Name" | Set-AzureRmRecoveryServicesVaultContext

$fnames = Get-AzureRmRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" | select  -ExpandProperty friendlyname

 foreach ($name in $fnames)
 {
 $nameContainer = Get-AzureRmRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -FriendlyName $name
 Get-AzureRmRecoveryServicesBackupItem -Container $nameContainer -WorkloadType "AzureVM" | select @{ Name = 'AzVM Name'; Expression = {$_.ContainerName.Split(';')[-1]} },LatestRecoveryPoint
 }

#We can also select {ProtectionStatus, ProtectionState, LastBackupTime, LatestRecoveryPoint}
#if want to export result add " | export-csv C:\temp\testbackup.csv -NoTypeInformation -Append" 
#E.G:-
#Get-AzureRmRecoveryServicesBackupItem -Container $nameContainer -WorkloadType "AzureVM" | select @{ n = 'AzVM Name'; e = {$_.ContainerName.Split(';')[-1]} },LatestRecoveryPoint | export-csv C:\temp\testbackup.csv -NoTypeInformation -Append
