DOCKER=docker compose
COMPOSER=symfony composer

composer-install:
	$(COMPOSER) install

docker-install: Dockerfile docker-compose.yaml clean
	$(DOCKER) down
	$(DOCKER) up -d --build
	$(DOCKER) ps
	$(DOCKER) logs -f

clean:
	rm -Rf bin config migrations public src tests translations var vendor .env .env.test .gitignore composer.* symfony.lock phpunit* templates

docker-sh:
	$(DOCKER) exec -it api sh