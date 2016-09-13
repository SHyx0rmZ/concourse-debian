.PHONY: clean dist dist-concourse-bin deb-concourse-bin

deb-concourse-bin:
	$(MAKE) -C .. deb-concourse-bin

dist:
	$(MAKE) -C .. dist

dist-concourse-bin:
	$(MAKE) -C .. dist-concourse-bin

$(CONCOURSE_BINARY_NAME).deb: $(CONCOURSE) concourse-bin/Makefile concourse-bin/control concourse-bin/md5sums
	mkdir -p $(CONCOURSE_BINARY_NAME)/usr/bin
	cp $(CONCOURSE) $(CONCOURSE_BINARY_NAME)/usr/bin/concourse
	chmod +x $(CONCOURSE_BINARY_NAME)/usr/bin/concourse
	mkdir -p $(CONCOURSE_BINARY_NAME)/DEBIAN
	cp concourse-bin/control $(CONCOURSE_BINARY_NAME)/DEBIAN/control
	sed -i -e "s/\$$(CONCOURSE_VERSION)/$(CONCOURSE_VERSION)/g" -e "s/\$$(BINARY_PACKAGE_VERSION)/$(BINARY_PACKAGE_VERSION)/g" -e "s/\$$(CONCOURSE_SIZE)/$$(($$(stat -c %s $(CONCOURSE) | awk '{ print $$1 }') / 1024 + 1))/g" $(CONCOURSE_BINARY_NAME)/DEBIAN/control
	echo "$$(md5sum $(CONCOURSE_BINARY_NAME)/usr/bin/concourse | sed -e 's/\s*$(CONCOURSE_BINARY_NAME)/ /')" > $(CONCOURSE_BINARY_NAME)/DEBIAN/md5sums
	chown -R root:root $(CONCOURSE_BINARY_NAME)
	dpkg-deb -Znone -Snone -b $(CONCOURSE_BINARY_NAME) $(CONCOURSE_BINARY_NAME).deb

$(CONCOURSE):
	curl -L -o $(CONCOURSE) https://github.com/concourse/concourse/releases/download/v$(CONCOURSE_VERSION)/concourse_linux_amd64

clean:
	$(MAKE) -C .. clean-concourse-bin