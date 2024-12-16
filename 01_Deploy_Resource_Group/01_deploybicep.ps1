

## Deploys the Bicep file in the resoruce group specified in the .env file

function Load-DotEnv {
    param (
        [string]$Path
    )
    if (Test-Path $Path) {
        Get-Content $Path | ForEach-Object {
            if ($_ -match "^\s*([^#][^=]*)\s*=\s*(.*)\s*$") {
                $name = $matches[1]
                $value = $matches[2]
                [System.Environment]::SetEnvironmentVariable($name, $value)
            }
        }
    } else {
        Write-Error "The .env file was not found at path: $Path"
        exit 1
    }
}

# Load environment variables from .env file
$envFilePath = ".env"
Load-DotEnv -Path $envFilePath

# Retrieve Environment Variables
$AzureTenantID = $env:AZURE_TENANT_ID
$AzureSubscriptionID = $env:AZURE_SUBSCRIPTION_ID
$AzureResourceGroupName = $env:AZURE_RESOURCE_GROUP_NAME
$BicepFile = "c:/GitHub/InfrastructureAsCode/Azure_deploy_AI_Services/01_Deploy_Resource_Group/deploy_aoai.bicep"

# Login to Azure
az login --tenant $AzureTenantID

# Sets the default subscription
az account set --subscription $AzureSubscriptionID

# Deploy the Bicep file in the specified resource group as a verbose and incremental deployment
az deployment group create `
    --resource-group $AzureResourceGroupName `
    --template-file $BicepFile `
    --mode Incremental `
    --verbose



