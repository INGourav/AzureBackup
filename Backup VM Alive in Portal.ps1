<#
This Script is wriiten to create or populate report of these VMs. Those are deleted from Azure but still protected by Azure Recovery Vault
Author : - Gourav Kumar
#>

Begin{
$Subs = Get-AzureRmSubscription | Select-Object -ExpandProperty Name
  foreach($sub in $Subs)
   {
 Set-AzureRmContext -Subscription $sub
   $RVS = Get-AzureRmRecoveryServicesVault
 foreach($RV in $RVS)
   {
  Set-AzureRmRecoveryServicesVaultContext -Vault $RV
    $RVNAME = $RV | Select-Object -ExpandProperty Name
  $Cont = Get-AzureRmRecoveryServicesBackupContainer -ContainerType AzureVM -Status Registered | Select-Object -ExpandProperty FriendlyName
 foreach($con in $Cont)
   {
  $VM = Get-AzureRmVM | Where {$_.Name -eq $con} | Select-Object -ExpandProperty Name
    if($VM)
    {
   #Uncomment Below line if you want to see reult on PowerShell host console
   #Write-Host  $VM ";VM Found in Subscription;" $sub  ";Sitting in;" $RVNAME ";Recovery Vault;"
   $VMINRV = New-Object psobject
   $VMINRV | Add-Member -MemberType NoteProperty -name Subscription -Value $sub
   $VMINRV | Add-Member -MemberType NoteProperty -name Server -Value $VM
   $VMINRV | Add-Member -MemberType NoteProperty -name RecoveryVault -Value $RVNAME
   $VMINRV | Export-Csv C:\Temp\vmfound.csv -Append -NoTypeInformation
   }
 else
    {
   # Uncomment Below line if you want to see reult on PowerShell host console
   #Write-Host  $con ";VM Not Found in Subscription;" $sub ";Sitting in;" $RVNAME ";Recovery Vault;"
   $VMNOTINRV = New-Object psobject
   $VMNOTINRV | Add-Member -MemberType NoteProperty -name Subscription -Value $sub
   $VMNOTINRV | Add-Member -MemberType NoteProperty -name Server -Value $con
   $VMNOTINRV | Add-Member -MemberType NoteProperty -name RecoveryVault -Value $RVNAME
   $VMNOTINRV | Export-Csv C:\Temp\vmnotfound.csv -Append -NoTypeInformation
   }
  }
 }
}
 }
End{}
