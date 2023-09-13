.PHONY: remove_images docker-down docker-compose-down docker-up maven-install maven-package maven-clean local-up local-down

IMAGE_PATTERNS = order-service inventory-service product-service notification-service api-gateway discovery-server

up: maven-install docker-up

down: docker-down

docker-up:
	echo "docker compose up"
	docker compose -f ./compose.docker.yml up -d

docker-down: docker-compose-down remove_images

docker-compose-down:
	echo "docker compose down"
	docker compose -f ./compose.docker.yml down -v

remove_images:
	@for pattern in ${IMAGE_PATTERNS}; do \
		echo "Checking for images matching pattern: $$pattern"; \
		if docker images | grep -q "$$pattern"; then \
		  echo "Removing images matching pattern: $$pattern"; \
		  docker rmi $$(docker images | grep "$$pattern" | awk '{print $$3}'); \
		else \
		  echo "No images found matching pattern: $$pattern"; \
		fi \
	done

local-up:
	echo "local docker compose up"
	docker compose -f ./compose.local.yml up -d

local-down:
	echo "local docker compose down"
	docker compose -f ./compose.local.yml down -v

maven-install:
	echo "Maven install"
	echo "spring-boot-microservices"
	./mvnw clean install -Dmaven.test.skip
	echo "api-gateway"
	cd ../api-gateway-2; \
	./mvnw clean install -Dmaven.test.skip
	echo "discovery-server"
	cd ../discovery-server-2; \
	./mvnw clean install -Dmaven.test.skip
	echo "inventory-service"
	cd ../inventory-service-2; \
	./mvnw clean install -Dmaven.test.skip
	echo "notification-service"
	cd ../notification-service-2; \
	./mvnw clean install -Dmaven.test.skip
	echo "order-service"
	cd ../order-service-2; \
	./mvnw clean install -Dmaven.test.skip
#	echo "product-service"
#	cd ../product-service-2; \
#	./mvnw clean install -Dmaven.test.skip






