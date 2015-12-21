#Requires -Version 3.0
#Requires -Module AzureRM.Resources
#Requires -Module Azure.Storage

Param(
    [string] $ResourceGroupLocation = 'westeurope',
    [string] [Parameter(Mandatory=$true)] $NameBase,
    [string] [Parameter(Mandatory=$true)] $Count,
    [string] $TemplateFile = '..\Templates\WindowsVirtualMachine.json',
    [string] $TemplateParametersFile = '..\Templates\WindowsVirtualMachine.parameters.json'
)

 
function Provision-VM( [string]$Name ) {
    Start-Job -ArgumentList $Name {
        param($Name)
         
$ResourceGroupName = $Name
$DNSName  = $Name
$ResourceGroupLocation = 'westeurope'

# Create or update the resource group using the specified template file and template parameters file
New-AzureRmResourceGroup -Name $Name -Location $ResourceGroupLocation -Verbose -Force -ErrorAction Stop 

New-AzureRmResourceGroupDeployment -Name ((Get-ChildItem $TemplateFile).BaseName + '-' + ((Get-Date).ToUniversalTime()).ToString('MMdd-HHmm')) `
                                   -ResourceGroupName $Name `
                                   -TemplateFile $TemplateFile  `
                                   -TemplateParameterFile $TemplateParametersFile `
								   -dnsNameForPublicIP $Name `
                                   -Verbose -Force
    }
}


#Login-AzureRmAccount
Select-AzureSubscription -SubscriptionName "Microsoft Azure Internal Consumption"

Provision-VM "htltest10"
Provision-VM "htltest11"

 
# Wait for all to complete
While (Get-Job -State "Running") {
    Get-Job -State "Completed" | Receive-Job
    Start-Sleep 1
}
 
# Display output from all jobs
Get-Job | Receive-Job
 
# Cleanup of jobs
Remove-Job *
 
# Displays batch completed
echo "Provisioning VM Completed"
                                   