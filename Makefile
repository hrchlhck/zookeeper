CLIENT_PORT := 2181
PORT_CMD := -p $(CLIENT_PORT):$(CLIENT_PORT)
MODE := -d

build:
	docker build -t vpemfh7/zookeeper .

server:
	docker run \
	$(MODE) \
	$(PORT_CMD)  \
	--rm \
	--name "zk-server" \
	vpemfh7/zookeeper \
	zkServer.sh start-foreground

cli:
	docker run \
	-it \
	--rm \
	--name "zk-cli" \
	vpemfh7/zookeeper \
	zkCli.sh -server $(shell docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' zk-server)


