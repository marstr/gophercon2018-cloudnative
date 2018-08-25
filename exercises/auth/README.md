# Intro

Create a web app which uses OAuth and OpenIDConnect to authenticate a user and get basic profile info.

# Details

1. Register an Application in the Microsoft directory and store its credentials for use in your app:

    ```
    1. Browse to https://apps.dev.microsoft.com and sign in.
    2. Click "Converged Applications" > "Add an App".
    3. Set a name for your app. Unselect "Guided setup".
    4. On the next page, copy the UUID for Application Id and paste it into
       `./go-auth/.env` as the value of `MSFT_CLIENT_ID`.
    5. Click "Generate New Password". Copy the generated password and paste it into
       `./go-auth/.env` next to `MSFT_CLIENT_SECRET`.
    6. Click "Add Platform" and select "Web". Type `http://localhost:8080` in the
       "Redirect URLs", and click "Add URL".
    7. Click "Delegated Permissions" > "Add". Select "email", "openid", and
       "profile" in addition to whatever is selected by default.
    8. Finally, scroll down and click "Save".
    ```

2. Open `./go-auth/main.go`. There are three registered handlers, each wrapped with Session and/or Authentication middleware.

3. Open `./go-auth/auth.go`. `withAuthentication` provides middleware to check if a user is authenticated and redirect them to a login server if not. `AuthzCodeHandler` handles the redirect back from the login server with the issued authorization code. This handler is responsible for exchanging the temporary code for access, refresh and ID tokens.

4. Run the server locally: `make server`. Browse to <http://localhost:8080>; you should be redirected to the Microsoft login server. Login, and you should be redirected back to the UserHandler in your app, which will now greet you by name!

5. Challenge: Change the code to log in with Google or GitHub auth.
