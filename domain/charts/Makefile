default: install

permissions:
	chmod 400 ~/.kube/config

install: permissions es_install customer1

es_install: permissions
	helm upgrade --values es.values.yaml --install rabbitmq ./external-service/

customer1: permissions
	bash ./scripts/install-webserver.sh "customer1"

customer2: permissions
	bash ./scripts/install-webserver.sh "customer2"