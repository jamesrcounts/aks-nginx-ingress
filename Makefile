default: all

all: azure

azure:
	cd infrastructure/azure && \
		make