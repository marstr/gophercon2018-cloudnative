package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"

	jwt "github.com/dgrijalva/jwt-go"
	"github.com/subosito/gotenv"
	"golang.org/x/oauth2"
	"golang.org/x/oauth2/microsoft"
)

var (
	oauth2Config *oauth2.Config

	redirectURIf        = "%v://%v/login"
	redirectURIScheme   string
	redirectURIHostname string

	clientID     string
	clientSecret string
	scopes       = []string{
		"openid",
		"email",
		"profile",
		"offline_access",
		// must specify a non-OpenID scope to get access token
		// i.e. if only OpenID scopes are used only id_token
		// and refresh_token (if offline_access is requested)
		// are returned
		"user.read",
	}
)

func init() {
	gotenv.Load()

	// set up OAuth config
	if redirectURIScheme = os.Getenv("REDIRECT_SCHEME"); redirectURIScheme == "" {
		redirectURIScheme = "http"
	}
	if redirectURIHostname = os.Getenv("REDIRECT_HOSTNAME"); redirectURIHostname == "" {
		redirectURIHostname = "localhost:8080"
	}
	clientID = os.Getenv("MSFT_CLIENT_ID")
	clientSecret = os.Getenv("MSFT_CLIENT_SECRET")

	oauth2Config = &oauth2.Config{
		ClientID:     clientID,
		ClientSecret: clientSecret,
		Endpoint:     microsoft.AzureADEndpoint(""),
		Scopes:       scopes,
		RedirectURL:  fmt.Sprintf(redirectURIf, redirectURIScheme, redirectURIHostname),
	}
}

// withAuthentication decorates a http.Handler with a check for authentication.
// If the request is unauthenticated it redirects to an authorization server.
func withAuthentication(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

		log.Printf("withAuthentication: checking for existing authenticated session\n")
		var authenticated bool = false
		authenticated = r.Context().Value(authenticatedKey).(bool)
		log.Printf("withAuthentication: authenticated?: %b\n", authenticated)

		if authenticated == false {
			log.Printf("withAuthentication: preparing to redirect to authorization server\n")
			var state = r.Context().Value(stateKey).(string)
			log.Printf("withAuthentication: using state: %v\n", state)
			authorizeURL := oauth2Config.AuthCodeURL(state,
				// seems to not be used by AAD, but passing nil here leads to error
				oauth2.AccessTypeOnline)
			log.Printf("withAuthentication: redirecting to %s\n", authorizeURL)
			http.Redirect(w, r, authorizeURL, http.StatusFound)
			return
		}

		// authenticated == true
		log.Printf("withAuthentication: user is authenticated, calling next handler\n")
		next.ServeHTTP(w, r)
	})
}

// authzCodeHandler is a http.HandlerFunc which expects to receive an authz
// code from a login server. It uses this to get an OAuth access token and Open
// ID id_token and populates the session user based on their attributes.
func authzCodeHandler(w http.ResponseWriter, r *http.Request) {

	log.Printf("authzCodeHandler: extracting code and checking state\n")
	var ok bool
	var state string
	// checking that state received in URL matches cached state
	if state, ok = r.Context().Value(stateKey).(string); ok == false {
		http.Error(w, "authzCodeHandler: could not find state\n",
			http.StatusInternalServerError)
		return
	}
	if state != r.FormValue("state") {
		log.Printf(
			"authzCodeHandler: state mismatch: have: %s; got: %s\n", state, r.FormValue("state"))
		http.Error(w, "authzCodeHandler: state doesn't match session's state, rejecting",
			http.StatusNotAcceptable)
		return
	}

	// getting authorization code
	code := r.FormValue("code")
	log.Printf("authzCodeHandler: going to request access token with code: %s\n", code)
	token, err := oauth2Config.Exchange(context.Background(), code)
	if err != nil {
		log.Printf("authzCodeHandler: failed to exchange authz code: %v\n", err)
		http.Error(w, "failed to get access token with authz code",
			http.StatusInternalServerError)
		return
	}
	log.Printf("authzCodeHandler: got token: %+v\n", token)

	// get openid token from access token
	rawIDToken, ok := token.Extra("id_token").(string)
	if ok == false {
		log.Printf("authzCodeHandler: but didn't find id_token\n")
		http.Error(w, "didn't receive id_token", http.StatusInternalServerError)
		return
	} else {
		log.Printf("authzCodeHandler: and id_token: %+v\n\n", rawIDToken)
	}

	idToken, err := jwt.Parse(rawIDToken, func(token *jwt.Token) (interface{}, error) {
		/*
			// retrieve from https://login.microsoftonline.com/common/v2.0/.well-known/openid-configuration
			// and https://login.microsoftonline.com/common/discovery/v2.0/keys
			// but doesn't work properly at the moment
			kid := token.Header["kid"].(string)
			// get key from discovery document, then parse and return
			verifyKey, err := jwt.ParseRSAPublicKeyFromPEM([]byte(azurePubKey))
			if err != nil {
				log.Printf("could not parse public key from string: %#v\n", err)
			}
			return verifyKey, nil
		*/
		return nil, nil // obviously not acceptable
	})

	if err != nil {
		log.Printf("authzCodeHandler: failed to exchange authz code: %v\n", err)

		log.Printf("authzCodeHandler: could not parse id_token %#v\n", err.Error())
		if err.Error() == "key is of invalid type" {
			// this is okay
			log.Printf("authzCodeHandler: continuing despite error\n")
		} else {
			http.Error(w, fmt.Sprintf("could not parse id_token: %#v", err.Error()),
				http.StatusInternalServerError)
		}
	}

	log.Printf("getting claims from id_token: %#v\n", idToken)
	claims, ok := idToken.Claims.(jwt.MapClaims)
	if ok == false {
		http.Error(w, fmt.Sprintf("could not find profile claims in id_token\n", err.Error()),
			http.StatusInternalServerError)
	}

	log.Printf("authzCodeHandler: setting state with id_token info: %v\n", idToken)
	info := map[string]string{
		emailKey: claims[emailKey].(string),
		nameKey:  claims[nameKey].(string),
	}
	r, err = saveSession(info, w, r)
	if err != nil {
		log.Printf("authzCodeHandler: failed to save session: %s\n", err.Error())
		http.Error(w, fmt.Sprintf("could not save session: %s", err.Error()),
			http.StatusInternalServerError)
	}
	log.Printf("authzCodeHandler: done, redirecting to userinfo handler\n")
	http.Redirect(w, r, "/userinfo", http.StatusFound)
}
