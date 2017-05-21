CONCOURSE_VERSION=1.6.0
META_PACKAGE_VERSION=1
WEB_PACKAGE_VERSION=1
WORKER_PACKAGE_VERSION=1
BINARY_PACKAGE_VERSION=1

CONCOURSE=concourse_linux_amd64.$(CONCOURSE_VERSION)
CONCOURSE_META_NAME=concourse_$(CONCOURSE_VERSION)-$(META_PACKAGE_VERSION)_amd64
CONCOURSE_WEB_NAME=concourse-web_$(CONCOURSE_VERSION)-$(WEB_PACKAGE_VERSION)_amd64
CONCOURSE_WORKER_NAME=concourse-worker_$(CONCOURSE_VERSION)-$(WORKER_PACKAGE_VERSION)_amd64
CONCOURSE_BINARY_NAME=concourse-bin_$(CONCOURSE_VERSION)-$(BINARY_PACKAGE_VERSION)_amd64

export

.PHONY: clean clean-concourse clean-concourse-bin clean-concourse-web clean-concourse-worker deb-concourse deb-concourse-bin deb-concourse-web deb-concourse-worker dist dist-concourse dist-concourse-bin dist-concourse-web dist-concourse-worker

dist: dist-concourse

dist-concourse: dist-concourse-web dist-concourse-worker
	$(MAKE) deb-concourse

dist-concourse-bin:
	$(MAKE) deb-concourse-bin

dist-concourse-web: dist-concourse-bin
	$(MAKE) deb-concourse-web

dist-concourse-worker: dist-concourse-bin
	$(MAKE) deb-concourse-worker

deb-concourse:
	$(MAKE) -C . -f concourse/Makefile $(CONCOURSE_META_NAME).deb

deb-concourse-bin:
	$(MAKE) -C . -f concourse-bin/Makefile $(CONCOURSE_BINARY_NAME).deb

deb-concourse-web:
	$(MAKE) -C . -f concourse-web/Makefile $(CONCOURSE_WEB_NAME).deb

deb-concourse-worker:
	$(MAKE) -C . -f concourse-worker/Makefile $(CONCOURSE_WORKER_NAME).deb

clean:
	$(MAKE) clean-concourse
	$(MAKE) clean-concourse-bin
	$(MAKE) clean-concourse-web
	$(MAKE) clean-concourse-worker

clean-concourse:
	-rm -r $(CONCOURSE_META_NAME)
	-rm $(CONCOURSE_META_NAME).deb

clean-concourse-bin:
	-rm -r $(CONCOURSE_BINARY_NAME)
	-rm $(CONCOURSE_BINARY_NAME).deb

clean-concourse-web:
	-rm -r $(CONCOURSE_WEB_NAME)
	-rm $(CONCOURSE_WEB_NAME).deb

clean-concourse-worker:
	-rm -r $(CONCOURSE_WORKER_NAME)
	-rm $(CONCOURSE_WORKER_NAME).deb
