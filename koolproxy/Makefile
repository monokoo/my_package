include $(TOPDIR)/rules.mk

PKG_NAME:=koolproxy
PKG_VERSION:=3.8.3
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/koolproxy
	SECTION:=net
	CATEGORY:=net
	TITLE:=Koolproxy
	MAINTAINER:=fw867
endef

define Package/koolproxy/description
	Koolproxy is an Powerful Advertisement Blocker
endef

define Build/Compile
endef

define Package/koolproxy/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/95-koolproxy ) && rm -f /etc/uci-defaults/95-koolproxy
	rm -f /tmp/luci-indexcache
fi
exit 0
endef

define Package/koolproxy/conffiles
/etc/config/koolproxy
/etc/dnsmasq.d/kpadblock.conf
endef


define Package/koolproxy/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/dnsmasq.d
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/share/koolproxy
	$(INSTALL_DIR) $(1)/usr/share/koolproxy/data
	$(INSTALL_DIR) $(1)/usr/share/koolproxy/data/rules/

	$(INSTALL_BIN) ./files/etc/uci-defaults/95-koolproxy $(1)/etc/uci-defaults/95-koolproxy
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	$(INSTALL_CONF) ./files/etc/dnsmasq.d/* $(1)/etc/dnsmasq.d/
	$(INSTALL_BIN) ./files/usr/sbin/* $(1)/usr/sbin/
	$(INSTALL_DATA) ./files/usr/share/koolproxy/adblock.conf $(1)/usr/share/koolproxy/adblock.conf
	$(INSTALL_BIN) ./files/usr/share/koolproxy/data/gen_ca.sh $(1)/usr/share/koolproxy/data/
	$(INSTALL_DATA) ./files/usr/share/koolproxy/data/openssl.cnf $(1)/usr/share/koolproxy/data/
	$(INSTALL_DATA) ./files/usr/share/koolproxy/data/rules/* $(1)/usr/share/koolproxy/data/rules/
	$(INSTALL_BIN) ./files/usr/share/koolproxy/camanagement $(1)/usr/share/koolproxy/camanagement
	$(INSTALL_BIN) ./files/usr/share/koolproxy/firewall.include $(1)/usr/share/koolproxy/firewall.include
	
	$(INSTALL_DIR) $(1)/lib/upgrade/keep.d
	$(INSTALL_DATA) ./files/lib/upgrade/keep.d/* $(1)/lib/upgrade/keep.d/

ifeq ($(ARCH),mipsel)
	$(INSTALL_BIN) ./files/bin/mipsel $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),mips)
	$(INSTALL_BIN) ./files/bin/mips $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),i386)
	$(INSTALL_BIN) ./files/bin/i386 $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),x86_64)
	$(INSTALL_BIN) ./files/bin/x86_64 $(1)/usr/share/koolproxy/koolproxy
endif
ifeq ($(ARCH),arm)
	$(INSTALL_BIN) ./files/bin/arm $(1)/usr/share/koolproxy/koolproxy
endif
endef

$(eval $(call BuildPackage,koolproxy))
