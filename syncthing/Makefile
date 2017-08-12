
include $(TOPDIR)/rules.mk

PKG_NAME:=syncthing
PKG_VERSION:=0.14.36
PKG_RELEASE:=20170812

include $(INCLUDE_DIR)/package.mk

define Package/syncthing
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Syncthing
	URL:=https://github.com/syncthing/syncthing
	DEPENDS:=+libc
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/syncthing/description
Syncthing replaces proprietary sync and cloud services with something open
endef

define Package/syncthing/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/99-syncthing ]; then
		( . /etc/uci-defaults/99-syncthing ) && rm -f /etc/uci-defaults/99-syncthing
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

define Package/syncthing/conffiles
/etc/config/syncthing
endef

define Package/syncthing/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/usr/sbin/* $(1)/usr/sbin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/

	$(INSTALL_DIR) $(1)/lib/upgrade/keep.d
	$(INSTALL_DATA) ./files/lib/upgrade/keep.d/* $(1)/lib/upgrade/keep.d/
	
	$(INSTALL_DIR) $(1)/usr/share/syncthing
	$(INSTALL_BIN) ./files/usr/share/syncthing/firewall.include $(1)/usr/share/syncthing/
	
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/99-syncthing $(1)/etc/uci-defaults/99-syncthing
	
endef

$(eval $(call BuildPackage,syncthing))
