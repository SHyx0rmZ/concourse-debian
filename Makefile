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

.PHONY: clean dist dist-concourse dist-concourse-bin dist-concourse-web dist-concourse-worker

dist: dist-concourse

dist-concourse: dist-concourse-web dist-concourse-worker
	$(MAKE) $(CONCOURSE_META_NAME).deb

dist-concourse-bin:
	$(MAKE) $(CONCOURSE_BINARY_NAME).deb

dist-concourse-web: dist-concourse-bin
	$(MAKE) $(CONCOURSE_WEB_NAME).deb

dist-concourse-worker: dist-concourse-bin
	$(MAKE) $(CONCOURSE_WORKER_NAME).deb

$(CONCOURSE_META_NAME).deb: concourse/control
	mkdir -p $(CONCOURSE_META_NAME)/DEBIAN
	cp concourse/control $(CONCOURSE_META_NAME)/DEBIAN/control
	chown -R root:root $(CONCOURSE_META_NAME)
	dpkg-deb -b $(CONCOURSE_META_NAME) $(CONCOURSE_META_NAME).deb

$(CONCOURSE_WEB_NAME).deb: concourse-web/control
	mkdir -p 

$(CONCOURSE_WORKER_NAME).deb: concourse-worker/control
	touch $@

$(CONCOURSE_BINARY_NAME).deb: $(CONCOURSE) concourse-bin/control concourse-bin/md5sums
	mkdir -p $(CONCOURSE_BINARY_NAME)/usr/bin
	cp $(CONCOURSE) $(CONCOURSE_BINARY_NAME)/usr/bin/concourse
	chmod +x $(CONCOURSE_BINARY_NAME)/usr/bin/concourse
	mkdir -p $(CONCOURSE_BINARY_NAME)/DEBIAN
	cp concourse-bin/control $(CONCOURSE_BINARY_NAME)/DEBIAN/control
	cp concourse-bin/md5sums $(CONCOURSE_BINARY_NAME)/DEBIAN/md5sums
	chown -R root:root $(CONCOURSE_BINARY_NAME)
	dpkg-deb -b $(CONCOURSE_BINARY_NAME) $(CONCOURSE_BINARY_NAME).deb

$(CONCOURSE):
	curl -L -o $(CONCOURSE) https://github.com/concourse/concourse/releases/download/v1.6.0/concourse_linux_amd64

clean:
	-rm -r $(CONCOURSE_BINARY_NAME)
	-rm -r $(CONCOURSE_META_NAME)
	-rm -r $(CONCOURSE_WEB_NAME)
	-rm -r $(CONCOURSE_WORKER_NAME)
	-rm $(CONCOURSE_BINARY_NAME).deb
	-rm $(CONCOURSE_META_NAME).deb
	-rm $(CONCOURSE_WEB_NAME).deb
	-rm $(CONCOURSE_WORKER_NAME).deb
