server:
	mkdir -p out
	go build -o out/webapp-server .
	./out/webapp-server &

stop-server:
	pkill --exact webapp-server

.PHONY: server stop-server
