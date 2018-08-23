.PHONY: all
all: azuredeploy.tf

azuredeploy.tf: writeconfig.pl
	perl writeconfig.pl 60 > azuredeploy.tf