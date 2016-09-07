.PHONY: clean dist dist-concourse-web deb-concourse-web

deb-concourse-web:
	$(MAKE) -C .. deb-concourse-web

dist:
	$(MAKE) -C .. dist

dist-concourse-web:
	$(MAKE) -C .. dist-concourse-web

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

clean:
	$(MAKE) -C .. clean-concourse-web