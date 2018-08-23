echo "getting packages..."
go get -v golang.org/x/tools/present
go get -v golang.org/x/tools/cmd/present
echo "presenting..."
present -notes=true
