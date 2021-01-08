default: all

all: azure kubernetes

azure:
	cd infrastructure/azure && \
		make

kubernetes:
	cd infrastructure/kubernetes && \
		make

