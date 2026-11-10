param location string = resourceGroup().location
resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: 'acrverifiedsupplychain'
  location: location
  sku: { name: 'Premium' }
  properties: { policies: { quarantinePolicy: { status: 'enabled' }, trustPolicy: { status: 'enabled', type: 'Notary' } } }
}
