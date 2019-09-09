# Get Azure Run As Connection Name
$connectionName = "AzureRunAsConnection"

# Get the Service Principal connection details for the Connection name
$servicePrincipalConnection = Get-AutomationConnection -Name $connectionName         

# Logging in to Azure AD with Service Principal
"Logging in to Azure AD..."
Connect-AzureAD -TenantId $servicePrincipalConnection.TenantId `
    -ApplicationId $servicePrincipalConnection.ApplicationId `
    -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint

# log in needed for Keyvault call
Add-AzureRmAccount `
    -ServicePrincipal `
    -TenantId $servicePrincipalConnection.TenantId `
    -ApplicationId $servicePrincipalConnection.ApplicationId `
    -CertificateThumbprint   $servicePrincipalConnection.CertificateThumbprint 


$AAD = (Get-AzureADTenantDetail).displayname

$results = @()

# only native cloud accounts where the users is enabled and 
$users = Get-AzureADUser -all:$true | Where-Object { ($_.LastDirSynctime -eq $null) -and ($_.AccountEnabled -eq $true) } 
foreach ($user in $users) {
    $myobject = [pscustomobject] @{
        "DisplayName"       = $user.displayname
        "UserPrincipalName" = $user.UserPrincipalName
        "AccountEnabled"    = $user.AccountEnabled
    }
    $results += $myobject
}

# get the permissions assigned on the subscription
$roles = Get-AzureRmRoleAssignment | Where-Object DisplayName -ne $null
$roleresults = @()
foreach ($role in $roles) {
    $myobject = [pscustomobject] @{
        "DisplayName"        = $role.displayname
        "SigninName"         = $role.SignInName
        "RoleDefinitionName" = $role.RoleDefinitionName
        "Scope"              = $role.Scope
    }
    $roleresults += $myobject
}
