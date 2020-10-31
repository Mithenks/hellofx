.PHONY: requirements create destroy start stop status clean build test test-debug run

MVN=./cmvn
include .env
USER_UID=$(shell id -u)
USER_GID=$(shell id -g)
CN="\\033[0m"
CR="\\033[91m"
CG="\\033[92m"
CY="\\033[93m"
CB="\\033[94m"
CT="\\033[37m"
TB="\\033[1m"
export

-include Makefile.local

all: help

help: requirements
	@echo ""
	@echo "============ ${TB}${CB}Project: ${PROJECT_NAME} (${PROJECT_VENDOR})${CN}"
	@echo ""
	@echo "  ${CY}make create${CN}      create docker environment for project"
	@echo "  ${CY}make run${CN}         run your application"
	@echo "  ${CY}make build${CN}       build your application"
	@echo "  ${CY}make test${CN}        run test suite"
	@echo "  ${CY}make test-debug${CN}  run test suite in debug mode"
	@echo "  ${CY}make logs${CN}        show logs from the docker container"
	@echo "  ${CY}make exec${CN}        run a shell inside the docker container"
	@echo "  ${CY}make start${CN}       start docker environment"
	@echo "  ${CY}make stop${CN}        stop docker environment"
	@echo "  ${CY}make status${CN}      show status of docker environment"
	@echo "  ${CY}make destroy${CN}     clean docker environment"
	@echo ""
	@echo " In order to interact with the docker environment, run ${CY}make create${CN}"
	@echo " Then, you can build and run your project with ${CY}make build run${CN}"
	@echo ""

requirements:
	@echo ""
	@echo "============ ${TB}${CB}Checking for system requirements${CN}"
	@echo ""
	docker --version
	docker-compose --version

create:
	docker-compose build --pull
	docker-compose up -d

destroy:
	docker-compose down -v
	docker-compose kill
	docker-compose rm -vf

start:
	docker-compose start

stop:
	docker-compose stop

status:
	docker-compose ps

logs:
	docker-compose logs

exec:
	.bmeme/bin/app

clean:
	${MVN} clean

build:
	${MVN} compile

test:
	${MVN} test

test-debug:
	${MVN} test -X

run:
	${MVN} javafx:run
