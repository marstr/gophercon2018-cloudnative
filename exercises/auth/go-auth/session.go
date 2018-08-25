package main

import (
	"context"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/sessions"
	"github.com/subosito/gotenv"
)

const (
	sessionName = "auth_sample"

	authenticatedKey = "authenticated"
	stateKey         = "state"
	nameKey          = "name"
	emailKey         = "email"
)

var store sessions.Store

func init() {
	gotenv.Load()
	cookie_key := os.Getenv("COOKIE_KEY")
	if len(cookie_key) == 0 {
		log.Printf("Session (init): specify a cookie key in ${COOKIE_KEY}\n", "COOKIE_KEY")
		cookie_key = "makemerandom"
	}

	log.Printf("Session (init): creating new session store with cookies\n")
	store = sessions.NewCookieStore([]byte(cookie_key))
}

// withSession decorates an http.Handler to add a session to a request. It
// populates context.Context with info about the session.
// To access this contenxt info in a later handler:
//   `authenticated, ok := r.Context().Value(authenticatedKey).(bool)`
//   `state, ok := r.Context().Value(stateKey).(string)`
func withSession(next http.Handler) http.Handler {

	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("withSession: getting session %v\n", sessionName)
		s, err := store.Get(r, sessionName)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
		}

		if _, ok := s.Values[stateKey].(string); ok == false {
			log.Printf("withSession: no state in session, adding it\n")

			state := "notrandomatthemoment"
			s.Values[stateKey] = state

			log.Printf("withSession: state set to [%s]\n", state)
		}

		if _, ok := s.Values[authenticatedKey].(bool); ok == false {
			log.Printf("withSession: redirecting unauthenticated user\n")
			s.Values[authenticatedKey] = false
		}

		log.Printf("withSession: saving session [%v]\n", s)
		_ = s.Save(r, w)

		log.Printf("withSession: adding session data to context\n")
		var ctx context.Context
		ctx = context.WithValue(ctx, authenticatedKey, s.Values[authenticatedKey])
		ctx = context.WithValue(ctx, stateKey, s.Values[stateKey])
		ctx = context.WithValue(ctx, nameKey, s.Values[nameKey])
		ctx = context.WithValue(ctx, emailKey, s.Values[emailKey])

		log.Printf("withSession: done, calling next with updated context:\n%+v\n", ctx)
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

// saveSession saves info into the current session and marks it authenticated.
func saveSession(info map[string]string, w http.ResponseWriter, r *http.Request) (*http.Request, error) {
	log.Printf("saveSession: getting session %v\n", sessionName)
	s, err := store.Get(r, sessionName)
	if err != nil {
		http.Error(w, "failed to get session", http.StatusInternalServerError)
		return nil, err
	}

	s.Values[authenticatedKey] = true
	for k, v := range info {
		log.Printf("saveSession: saving key [%s] value [%s]\n", k, v)
		s.Values[k] = v
		r = r.WithContext(context.WithValue(r.Context(), k, v))
	}
	err = s.Save(r, w)
	return r, err
}
