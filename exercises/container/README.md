#  Intro

In this lab you will create a continuously-deployed, container-based web app from the code in `./go-sample`.

1. Create an app and associated GitHub repo.
1. Create a container registry and a repo for the app's image.
1. Create a Web App which runs the app and continuously redeploys the container when udpated.
1. Make a change to your code and watch the Web App update!

# Details

1. Create a GitHub repo for your app: click the "+" sign next to your profile
picture on GitHub and select "New Repository". You can name it "go-sample" and
leave the other settings at defaults.

1. Configure the go-sample app and push it to your new repo:

	```
	cd ./go-sample
	git init
	git remote add origin https://github.com/<your_name>/go-sample.git
	git add .
	git commit -m "initial commit"
	git push origin master
	```

1. Create a registry to store this and other images:

	```
	group_name=<your_group_name>
	image_tag=<your_name>/go-sample:latest
	github_repo=https://github.com/<your_name>/<project_name>.git

    # lowercase and no special chars
	registry_name=<your_name>registry
	plan_name=<your_name>-plan
	webapp_name=<your_name>-webapp

	az acr create \
		--name $registry_name \
		--resource-group $group_name \
		--sku 'Standard' \
		--admin-enabled 'true' \
		--location westus2

	registry_prefix=$(az acr show \
		--name ${registry_name} --resource-group ${group_name} --output tsv --query 'loginServer')
	registry_password=$(az acr credential show \
		--name ${registry_name} --output tsv --query 'passwords[0].value')
	registry_username=$(az acr credential show \
		--name ${registry_name} --output tsv --query 'username')
	image_uri=${registry_prefix}/${image_tag}
	```

1. Create a repository for your image and configure build tasks. Then kick off a build!

	You'll need to get a personal access token from GitHub at <https://github.com/settings/tokens> and set it in GH\_TOKEN. This is used to set up a persistent webhook in the GitHub repo.

	```
	GH_TOKEN=
	buildtask_name=buildoncommit
	az acr build-task create \
		--name ${buildtask_name} \
		--registry ${registry_name} \
		--resource-group ${group_name} \
		--context ${github_repo} \
		--git-access-token ${GH_TOKEN} \
		--image "${image_tag}" \
		--branch 'master' \
		--commit-trigger-enabled 'true' \
		--file 'Dockerfile'

    # run once now
	az acr build-task run \
		--name ${buildtask_name} \
		--registry ${registry_name} \
		--resource-group ${group_name}
	```

1. Create an App Service Web App to run your image and continuous redeploy it when the container changes.

	```
	az appservice plan create --is-linux \
		--name $plan_name \
		--resource-group $group_name \
		--location westus2

	az webapp create \
		--name $webapp_name \
		--plan $plan_name \
		--resource-group $group_name \
		--deployment-container-image-name $image_uri

	webapp_id=$(az webapp show --name $webapp_name --resource-group $group_name --output tsv --query id)

	az webapp config container set \
		--ids $webapp_id \
		--docker-custom-image-name $image_uri \
		--docker-registry-server-url "https://${registry_prefix}" \
		--docker-registry-server-user $registry_username \
		--docker-registry-server-password $registry_password

	az webapp deployment container config \
		--ids $webapp_id \
		--enable-cd 'true'
	```

1. Browse to your web app at <https://${webapp_name}.azurewebsites.net/>. Yay!

1. Now make a change to the output of your app in `main.go`, then add, commit and push it to your GitHub repo. After about 2 minutes browse to it again and your changes should be there.

Congratulations! You've built a continuously-deployed web app!
