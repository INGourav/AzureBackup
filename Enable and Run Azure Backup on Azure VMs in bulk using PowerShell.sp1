#Author: - Gourav Kumar
#Reach Me: - gouravin@outlook.com or gouravrathore23@gmail.com
#Feel free to edit and share review


#stroing vault name in variable

$vault= Get-AzureRmRecoveryServicesVault | where{$_.Name -eq "vaultname"} | Select-Object -ExpandProperty Name

#List Azure recovery valult and set backup redundency locally, I am taking locally in this script

Get-AzureRmRecoveryServicesVault -Name $vault | Set-AzureRmRecoveryServicesBackupProperties -BackupStorageRedundancy LocallyRedundant

#List Azure recovery valult and set backup redundency Geo, if you taking this option then comment the above line and uncomment the below line

#Get-AzureRmRecoveryServicesVault -Name $vault | Set-AzureRmRecoveryServicesBackupProperties -BackupStorageRedundancy GeoRedundant

#Now setting vault to for further use

Set-AzureRmRecoveryServicesVaultContext -Vault $vault
#Get-AzurermRecoveryServicesVault -Name "vaultname" | Set-AzurermRecoveryServicesVaultContext

#Storing policy inside the vaiable for further use

$policy= Get-AzurermRecoveryServicesBackupProtectionPolicy -Name "BackupPolicyName"

#Last step to enable backup on VM

Enable-AzurermRecoveryServicesBackupProtection -ResourceGroupName "VM_RG_Name" -Name "VM_Name" -Policy $policy


##Now time to initate backup job on servers

#storing VM data into Variables if you have number of VMs in different RGs then copy names in CSV and use get content to pasre data
$vm=Get-Content -Path C:\Users\kumar_g\Desktop\Azvmbackup.csv

#However if you have single VM we could use below line. Simply uncomment the below one and Comment the above line in Script.
#$vm= Get-AzureRmVM -ResourceGroupName "VM_RG_Name" -Name "VM Name"

#running script for each VMs
foreach($v in $vm)
{
#Telling script to use Azure VM container for $v VMs
$backupcontainer = Get-AzurermRecoveryServicesBackupContainer -ContainerType "AzureVM" -FriendlyName $v

#Getting ready and Creating backup
$item = Get-AzurermRecoveryServicesBackupItem -Container $backupcontainer -WorkloadType "AzureVM"

#Displaying VM and their status about Backup
Backup-AzurermRecoveryServicesBackupItem -Item $item
}


#End of Script
#Hope you liked it :)
#Thanks for using, Do share feedback.
#Keep Automating with PowerShell


