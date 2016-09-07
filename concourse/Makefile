.PHONY: clean dist dist-concourse deb-concourse

deb-concourse:
	$(MAKE) -C .. deb-concourse

dist:
	$(MAKE) -C .. dist

dist-concourse:
	$(MAKE) -C .. dist-concourse

$(CONCOURSE_META_NAME).deb: concourse/control
	mkdir -p $(CONCOURSE_META_NAME)/DEBIAN
	cp concourse/control $(CONCOURSE_META_NAME)/DEBIAN/control
	sed -i -e "s/\$$(CONCOURSE_VERSION)/$(CONCOURSE_VERSION)/g" -e "s/\$$(META_PACKAGE_VERSION)/$(META_PACKAGE_VERSION)/g" $(CONCOURSE_META_NAME)/DEBIAN/control
	chown -R root:root $(CONCOURSE_META_NAME)
	dpkg-deb -b $(CONCOURSE_META_NAME) $(CONCOURSE_META_NAME).deb

clean:
	$(MAKE) -C .. clean-concourse