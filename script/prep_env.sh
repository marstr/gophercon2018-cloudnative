# shared resources and connection strings
shared_group_name=gophercon-shared
runtime_image_uri=joshgav/azure-functions-go:latest

storage_account_id="/subscriptions/dbc9e9c9-5cfe-4749-8772-8517bcbb5be9/resourceGroups/gophercon-shared/providers/Microsoft.Storage/storageAccounts/gcfunctesterstorsmoker"
appservice_plan_id='/subscriptions/dbc9e9c9-5cfe-4749-8772-8517bcbb5be9/resourceGroups/gophercon-shared/providers/Microsoft.Web/serverfarms/azure-functions-gophercon-tester-plan'
sb_connstr='Endpoint=sb://gcfunctestersbsmoker.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=CcQXIy7TrbJlI+I3caDyhqBi4sh0npt9WOQscrTLq1I='
eh_connstr='Endpoint=sb://gcfunctesterehsmoker.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=z9TOAzOX1EIUBWA9mWY00Mfn4AEX7iXHeNKQz25mOqs='
cdb_connstr='AccountEndpoint=https://gcfunctestercosmossmoker.documents.azure.com:443/;AccountKey=PerNoDjfjU2je2ioJur9qSd1p7yFD1xvLAtU7xCdR6mpfKySifu9Vf6ekFhugnu2WUnB9o8BnquyanZXzsvSWg==;'

declare -a settings=(
	"ServiceBusConnectionString=$sb_connstr" \
	"EventHubsConnectionString=$eh_connstr" \
	"CosmosDBConnectionString=$cdb_connstr"
)
# /end shared resources and connection strings
