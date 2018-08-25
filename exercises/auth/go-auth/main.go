package main

import (
	"fmt"
	"golang.org/x/net/html"
	"log"
	"net/http"
	"os"
)

func main() {
	// find port selected by service, default to 8080
	var port string
	var found bool
	port, found = os.LookupEnv("PORT")
	if found == true {
		// prepend a colon
		port = fmt.Sprintf(":%s", port)
	} else {
		port = ":8080"
	}

	http.Handle("/", withSession(withAuthentication(http.HandlerFunc(tester))))
	http.Handle("/login", withSession(http.HandlerFunc(authzCodeHandler)))
	http.Handle("/userinfo", withSession(withAuthentication(http.HandlerFunc(userInfoHandler))))

	log.Fatal(http.ListenAndServe(port, nil))
}

// tester
func tester(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello %s!", html.EscapeString(
		r.URL.Query().Get("name")))
	log.Printf("request received, details follow:\n%+v\n", r)
}

// userInfoHandler prints a message with the logged on user's name retrieved
// from the session.
func userInfoHandler(w http.ResponseWriter, r *http.Request) {
	log.Printf("userInfoHandler: request received [%+v]\n", r)
	name := r.Context().Value("name").(string)
	fmt.Fprintf(w, "Hello %s!", html.EscapeString(name))
}
