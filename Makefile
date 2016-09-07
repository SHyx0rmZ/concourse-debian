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

.PHONY: clean deb-concourse deb-concourse-bin deb-concouse-web deb-concourse-worker dist dist-concourse dist-concourse-bin dist-concourse-web dist-concourse-worker

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
	$(MAKE) $(CONCOURSE_META_NAME).deb

deb-concourse-bin:
	$(MAKE) $(CONCOURSE_BINARY_NAME).deb

deb-concourse-web:
	$(MAKE) $(CONCOURSE_WEB_NAME).deb

deb-concourse-worker:
	$(MAKE) $(CONCOURSE_WORKER_NAME).deb

$(CONCOURSE_META_NAME).deb: concourse/control
	mkdir -p $(CONCOURSE_META_NAME)/DEBIAN
	cp concourse/control $(CONCOURSE_META_NAME)/DEBIAN/control
	sed -i -e "s/\$$(CONCOURSE_VERSION)/$(CONCOURSE_VERSION)/g" -e "s/\$$(META_PACKAGE_VERSION)/$(META_PACKAGE_VERSION)/g" $(CONCOURSE_META_NAME)/DEBIAN/control
	chown -R root:root $(CONCOURSE_META_NAME)
	dpkg-deb -b $(CONCOURSE_META_NAME) $(CONCOURSE_META_NAME).deb

$(CONCOURSE_WEB_NAME).deb: concourse-web/control concourse-web/postinst concourse-web/postrm concourse-web/prerm concourse-web/concourse-web concourse-web/concourse-web.service concourse-web/web
	mkdir -p $(CONCOURSE_WEB_NAME)/etc/concourse
	cp concourse-web/web $(CONCOURSE_WEB_NAME)/etc/concourse/web
	chmod 0640 $(CONCOURSE_WEB_NAME)/etc/concourse/web
	mkdir -p $(CONCOURSE_WEB_NAME)/usr/bin
	cp concourse-web/concourse-web $(CONCOURSE_WEB_NAME)/usr/bin/concourse-web
	chmod +x $(CONCOURSE_WEB_NAME)/usr/bin/concourse-web
	mkdir -p $(CONCOURSE_WEB_NAME)/usr/lib/systemd/system
	cp concourse-web/concourse-web.service $(CONCOURSE_WEB_NAME)/usr/lib/systemd/system/concourse-web.service
	mkdir -p $(CONCOURSE_WEB_NAME)/usr/lib/concourse
	mkdir -p $(CONCOURSE_WEB_NAME)/var/cache/concourse
	mkdir -p $(CONCOURSE_WEB_NAME)/var/lib/concourse
	mkdir -p $(CONCOURSE_WEB_NAME)/DEBIAN
	cp concourse-web/control $(CONCOURSE_WEB_NAME)/DEBIAN/control
	sed -i -e "s/\$$(CONCOURSE_VERSION)/$(CONCOURSE_VERSION)/g" -e "s/\$$(WEB_PACKAGE_VERSION)/$(WEB_PACKAGE_VERSION)/g" $(CONCOURSE_WEB_NAME)/DEBIAN/control
	cp concourse-web/postinst $(CONCOURSE_WEB_NAME)/DEBIAN/postinst
	chmod +x $(CONCOURSE_WEB_NAME)/DEBIAN/postinst
	cp concourse-web/postrm $(CONCOURSE_WEB_NAME)/DEBIAN/postrm
	chmod +x $(CONCOURSE_WEB_NAME)/DEBIAN/postrm
	cp concourse-web/prerm $(CONCOURSE_WEB_NAME)/DEBIAN/prerm
	chmod +x $(CONCOURSE_WEB_NAME)/DEBIAN/prerm
	chown -R root:root $(CONCOURSE_WEB_NAME)
	dpkg-deb -b $(CONCOURSE_WEB_NAME) $(CONCOURSE_WEB_NAME).deb

$(CONCOURSE_WORKER_NAME).deb: concourse-worker/control concourse-worker/postinst concourse-worker/postrm concourse-worker/prerm concourse-worker/concourse-worker concourse-worker/concourse-worker.service concourse-worker/worker
	mkdir -p $(CONCOURSE_WORKER_NAME)/etc/concourse
	cp concourse-worker/worker $(CONCOURSE_WORKER_NAME)/etc/concourse/worker
	chmod 0640 $(CONCOURSE_WORKER_NAME)/etc/concourse/worker
	mkdir -p $(CONCOURSE_WORKER_NAME)/usr/bin
	cp concourse-worker/concourse-worker $(CONCOURSE_WORKER_NAME)/usr/bin/concourse-worker
	chmod +x $(CONCOURSE_WORKER_NAME)/usr/bin/concourse-worker
	mkdir -p $(CONCOURSE_WORKER_NAME)/usr/lib/systemd/system
	cp concourse-worker/concourse-worker.service $(CONCOURSE_WORKER_NAME)/usr/lib/systemd/system/concourse-worker.service
	mkdir -p $(CONCOURSE_WORKER_NAME)/usr/lib/concourse
	mkdir -p $(CONCOURSE_WORKER_NAME)/var/cache/concourse
	mkdir -p $(CONCOURSE_WORKER_NAME)/DEBIAN
	cp concourse-worker/control $(CONCOURSE_WORKER_NAME)/DEBIAN/control
	sed -i -e "s/\$$(CONCOURSE_VERSION)/$(CONCOURSE_VERSION)/g" -e "s/\$$(WORKER_PACKAGE_VERSION)/$(WORKER_PACKAGE_VERSION)/g" $(CONCOURSE_WORKER_NAME)/DEBIAN/control
	cp concourse-worker/postinst $(CONCOURSE_WORKER_NAME)/DEBIAN/postinst
	chmod +x $(CONCOURSE_WORKER_NAME)/DEBIAN/postinst
	cp concourse-worker/postrm $(CONCOURSE_WORKER_NAME)/DEBIAN/postrm
	chmod +x $(CONCOURSE_WORKER_NAME)/DEBIAN/postrm
	cp concourse-worker/prerm $(CONCOURSE_WORKER_NAME)/DEBIAN/prerm
	chmod +x $(CONCOURSE_WORKER_NAME)/DEBIAN/prerm
	chown -R root:root $(CONCOURSE_WORKER_NAME)
	dpkg-deb -b $(CONCOURSE_WORKER_NAME) $(CONCOURSE_WORKER_NAME).deb

$(CONCOURSE_BINARY_NAME).deb: $(CONCOURSE) concourse-bin/control concourse-bin/md5sums
	mkdir -p $(CONCOURSE_BINARY_NAME)/usr/bin
	cp $(CONCOURSE) $(CONCOURSE_BINARY_NAME)/usr/bin/concourse
	chmod +x $(CONCOURSE_BINARY_NAME)/usr/bin/concourse
	mkdir -p $(CONCOURSE_BINARY_NAME)/DEBIAN
	cp concourse-bin/control $(CONCOURSE_BINARY_NAME)/DEBIAN/control
	sed -i -e "s/\$$(CONCOURSE_VERSION)/$(CONCOURSE_VERSION)/g" -e "s/\$$(BINARY_PACKAGE_VERSION)/$(BINARY_PACKAGE_VERSION)/g" $(CONCOURSE_BINARY_NAME)/DEBIAN/control
	echo "$(md5sum ${CONCOURSE} | awk '{ print $1 }') /usr/bin/concourse" > $(CONCOURSE_BINARY_NAME)/DEBIAN/md5sums
	chown -R root:root $(CONCOURSE_BINARY_NAME)
	dpkg-deb -Znone -Snone -b $(CONCOURSE_BINARY_NAME) $(CONCOURSE_BINARY_NAME).deb

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
