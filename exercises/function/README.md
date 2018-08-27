# Intro

In this exercise you will:

1. Create a function app.
1. Test the sample HttpTrigger built in to the function app image.
1. Write and deploy your own HTTP Trigger function to your function app.

# Details

1. Create a function app by running the following commands one by one. Replace `functionapp_name` and `group_name` with your name and the group assigned to you.

	```
	functionapp_name=<your_name>-function
	group_name=<your_group>

	source ./script/prep_env.sh

	az login --tenant <provided tenant id>

	functionapp_id=$(az functionapp create \
		--name $functionapp_name \
		--resource-group $group_name \
		--storage-account $storage_account_id \
		--plan $appservice_plan_id \
		--deployment-container-image-name $runtime_image_uri \
		--query id --output tsv)

	az functionapp show --ids $functionapp_id

	az functionapp config appsettings set \
		--ids $functionapp_id \
		--settings $settings

	az webapp log config --ids $functionapp_id --docker-container-logging filesystem
	```

1. Test the HttpTrigger in your function app using curl.

	```
	person_name="world"
	url="http://${functionapp_name}.azurewebsites.net/api/HttpTrigger?name=${person_name}"
	body='{"greeting":"Where would you like to go today?"}'

	curl -L "$url" \
		--data "$body" \
		--header 'Content-Type: application/json'
	```

1. Review logs:

	* Browse to <https://$functionapp_name}.scm.azurewebsites.net/api/logs/docker>. **Note .scm. in the hostname.**
	* Click the file ending in '\_default\_docker.log', which contains stdout and stderr from the container.
	* Click the other file ending in `\_docker.log', which contains stdout and stderr from the host starting the container.

1. Write your own function.

	```
	function_name=<your_name>-function
	mkdir $function_name && cd $function_name
	touch function.json
	touch main.go
	```

    Now open and copy `function.json` and `main.go` from the HttpTrigger folder into your folder.

    **Extra credit!** Modify the function to include a goodbye greeting for the User struct as well.

1. Deploy your function.

    * First, configure your functionapp to run user functions rather than builtin samples with the following command. After the change it may take your app up to 2 minutes to reconfigure itself.

	```
	az functionapp config appsettings set \
		--ids $functionapp_id \
		--settings "WEBSITES_ENABLE_APP_SERVICE_STORAGE=true"
	```

    * Now build and zip your function up:

	```
	go build -buildmode=plugin -o bin/${function_name}.so main.go"
	cd ..
	zip -r function.zip ${function_name}/
	```

    * And deploy:

	```
	az functionapp deployment source config-zip --ids $functionapp_id --src function.zip
	```

    Now you can verify your function works by sending requests from curl or [Postman](https://www.getpostman.com/apps).

Congratulations! You've deploy a Go function to Azure Functions.
