# If Makefile.local exists, include it
ifneq ("$(wildcard Makefile.local)", "")
	include Makefile.local
endif

DOCKERTAG := darinegan/openstack-client

CURRENT_DIR := $(shell pwd)
OPENRC_SH ?= $(CURRENT_DIR)/openrc.sh
OS_CACERT ?= $(CURRENT_DIR)/os-cacert.crt

.PHONY: default build clean verify run

default: run

build:
	docker build -t $(DOCKERTAG) .

clean:
	docker rmi $(DOCKERTAG)

verify:
	@echo "Verifying required files"
	@for file in $(OPENRC_SH) $(OS_CACERT); do \
		if test ! -e $$file ; then \
			echo "### Error: $$file does not exist" ; \
			exit 1 ; \
		fi ; \
	done

run: build verify
	docker run --rm -it \
		-v $(OPENRC_SH):/openrc.sh \
		-e OS_CACERT=$(OS_CACERT) \
		-v $(OS_CACERT):$(OS_CACERT) \
		$(DOCKERTAG)
