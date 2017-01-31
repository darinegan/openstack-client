# If Makefile.local exists, include it
ifneq ("$(wildcard Makefile.local)", "")
	include Makefile.local
endif

DOCKERTAG := darinegan/openstack-client

CURRENT_DIR := $(shell pwd)
OPENRC_SH ?= $(CURRENT_DIR)/openrc.sh
OS_CACERT ?= $(CURRENT_DIR)/os-cacert.crt

HOST_URL := $(shell awk -F'/' '/OS_AUTH_URL=/{print $$3}' $(OPENRC_SH))

.PHONY: default build clean configure verify run

default: build

build:
	docker build -t $(DOCKERTAG) .

clean:
	docker rmi $(DOCKERTAG)

configure: verify
	@echo -n | openssl s_client -showcerts -connect $(HOST_URL) 2>&1 | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p'

verify:
	@echo "Verifying required files"
	@for file in $(OPENRC_SH) $(OS_CACERT); do \
		if test ! -e $$file ; then \
			echo "### Error: $$file does not exist" ; \
			exit 1 ; \
		fi ; \
	done

run: verify
	docker run --rm -it \
		-v $(OPENRC_SH):/openrc.sh \
		-e OS_CACERT=$(OS_CACERT) \
		-v $(OS_CACERT):$(OS_CACERT) \
		$(DOCKERTAG)
