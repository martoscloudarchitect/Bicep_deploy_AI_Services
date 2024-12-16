/// Deploys an Azure OpenAI Service to an existing resoruce group and on the same location as the resource group.

param location string = resourceGroup().location
param openaiServiceName string = 'openai-service'
param openaiServiceSku string = 'S0'
param openaiServiceKind string = 'OpenAI'
param gpt4NameAndModel string = 'gpt-4o'

resource openaiService 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: openaiServiceName
  location: location
  kind: openaiServiceKind
  sku: {
    name: openaiServiceSku
  }
  properties: {
    publicNetworkAccess: 'Enabled'    
  }
  tags: {
    environment: 'dev'
    deployment: 'bicep'
  }
}
