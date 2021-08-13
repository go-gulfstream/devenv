PROJECT_PATH = $(PWD)

DEPLOYMENTS_LOCAL_RUN = @docker-compose                          \
      -f $(PROJECT_PATH)/network.yml                             \
      -f $(PROJECT_PATH)/kafka.yml                               \
      -f $(PROJECT_PATH)/kafka-kowl.yml                          \
      -f $(PROJECT_PATH)/postgres.yml                            \
      -f $(PROJECT_PATH)/postgres-pgadmin.yml                    \
      -f $(PROJECT_PATH)/redis.yml                               \
      -f $(PROJECT_PATH)/nats.yml                                \
      -f $(PROJECT_PATH)/gs-connector.yml                        \

.PHONY: up
up: clean
	@$(DEPLOYMENTS_LOCAL_RUN) up -d
	@sleep 15s

.PHONY: down
down:
	@$(DEPLOYMENTS_LOCAL_RUN)  down --volumes

.PHONY: clean
clean:
	$(docker stop $(docker ps -a -q))
	$(docker rm $(docker ps -a -q))
	@rm -Rf ./tmp
