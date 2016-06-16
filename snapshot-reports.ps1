Param(
    [string] $Hostname,
    [string] $User,
	[String] $Pass,
	[String] $Report
 )
 
 if ($psboundparameters.count -ne 4) {
	Write-Host "Usage:"
	Write-Host "Snapshot-report.ps1 -Hostname <hostname> -User <user> -Pass <password> -Report <name of html report file>"
 }
 else {
Connect-VIServer $Hostname -User $User -Password $Pass
$SnapshotReport = Get-VM | Get-Snapshot | Select VM,Name,Description,@{Label="Size";Expression={"{0:N2} GB" -f ($_.SizeGB)}},Created
$SnapshotReport = $SnapshotReport | Select VM,Name,Description,Size,Created | ConvertTo-Html -Head $Header -PreContent "<p><h2>Snapshot Report - $VIServer</h2></p><br>" > $Report
}

