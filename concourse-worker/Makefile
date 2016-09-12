.PHONY: clean dist dist-concourse-worker deb-concourse-worker

deb-concourse-worker:
	$(MAKE) -C .. deb-concourse-worker

dist:
	$(MAKE) -C .. dist

dist-concourse-worker:
	$(MAKE) -C .. dist-concourse-worker

$(CONCOURSE_WORKER_NAME).deb: concourse-worker/Makefile concourse-worker/control concourse-worker/postinst concourse-worker/postrm concourse-worker/prerm concourse-worker/concourse-worker concourse-worker/concourse-worker.service concourse-worker/worker
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
	cp concourse-worker/conffiles $(CONCOURSE_WORKER_NAME)/DEBIAN/conffiles
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

clean:
	$(MAKE) -C .. clean-concourse-worker