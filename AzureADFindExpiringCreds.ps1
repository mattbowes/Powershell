$daystomonitor = 90
$results = @()

$azureapps = Get-AzureRMADApplication 
foreach ($app in $azureapps) {
    $expiringcred = Get-AzureRMADAppCredential -ObjectId $app.ObjectId
    foreach ($e in $expiringcred) {
        if ($null -ne $e.enddate) {
            if ([datetime]$e.enddate -lt (get-date).AddDays($daystomonitor) -and ([datetime]$e.enddate -ge (get-date))) {
                $results += [PSCustomObject]@{
                    AzureADName   = $app.displayname
                    StartDate     = $e.StartDate
                    EndDate       = $e.EndDate
                    Type          = $e.Type
                    applicationId = $app.applicationId
                }
            }
        }
    }
}


$azuresp = Get-AzureRMADServicePrincipal 
foreach ($sp in $azuresp) {
    $spc = get-AzureRMADServicePrincipalCredential -ObjectId $sp.id
    foreach ($s in $spc) {
        if ($null -ne $s.enddate) {
            if ( [datetime]$s.enddate -lt (get-date).AddDays($daystomonitor) -and ([datetime]$s.enddate -ge (get-date))) {
                $results += [PSCustomObject]@{
                    AzureADName   = $sp.DisplayName
                    StartDate     = $s.StartDate
                    EndDate       = $s.EndDate
                    Type          = $s.Type
                    applicationId = $sp.applicationId
                }
            }
        }
    }
}
