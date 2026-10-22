@description('Short name: 3 to 11 lowercase letters and numbers')
@minLength(3)
@maxLength(11)
param name string

var accountName = '${toLower(name)}${uniqueString(resourceGroup().id)}'

resource storage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: accountName
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: {
    'cost-centre': 'team-a'
  }
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    publicNetworkAccess: 'Disabled'
  }
}

output storageAccountName string = storage.name
