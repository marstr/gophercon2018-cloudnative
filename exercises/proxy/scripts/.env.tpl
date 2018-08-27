# used by setup script
AZURE_BASE_NAME=go-athens
AZURE_DEFAULT_LOCATION=westus2

# for: memory, disk, mongo, minio, gcp
ATHENS_STORAGE_TYPE=mongo
ATHENS_MONGO_CONNECTION_STRING=

# logging
BUFFALO_LOG_LEVEL=debug
ATHENS_LOG_LEVEL=debug

# for ?
# ATHENS_CLOUD_RUNTIME=

# Athens WebApp port
# PORT=

# for worker queue (not currently used)
# can accept a full hostname+port
# ATHENS_REDIS_QUEUE_PORT=


# for goget impl of download.Protocol
# GO_BINARY_PATH=go

# this defaults internally to http://localhost:3001
# OLYMPUS_GLOBAL_ENDPOINT=
