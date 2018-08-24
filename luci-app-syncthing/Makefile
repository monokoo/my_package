include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-syncthing
PKG_VERSION:=20170815
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=LuCI Support for syncthing
        DEPENDS:=+syncthing
endef

define Package/$(PKG_NAME)/description
    LuCI Support for syncthing, forked from koolshare Lede X64. Thanks to fw867.
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/40_luci-syncthing ]; then
		( . /etc/uci-defaults/40_luci-syncthing ) && rm -f /etc/uci-defaults/40_luci-syncthing
	fi
	rm -rf /tmp/luci-indexcache
fi
exit 0
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/* $(1)/etc/uci-defaults/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/i18n/*.lmo $(1)/usr/lib/lua/luci/i18n/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/syncthing
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/syncthing/* $(1)/usr/lib/lua/luci/view/syncthing/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/syncthing
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/syncthing/*.lua $(1)/usr/lib/lua/luci/model/cbi/syncthing/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))