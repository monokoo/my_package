include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-homekit
PKG_VERSION:=20170609
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=luci for homekit
        DEPENDS:=+libc +homekit
endef

define Package/$(PKG_NAME)/description
    A luci app for homekit, forked from koolshare Lede X64. Thanks to fw867.
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/40_luci-homekit ]; then
		( . /etc/uci-defaults/40_luci-homekit ) && rm -f /etc/uci-defaults/40_luci-homekit
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
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/homekit
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/homekit/* $(1)/usr/lib/lua/luci/view/homekit/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/homekit
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/homekit/*.lua $(1)/usr/lib/lua/luci/model/cbi/homekit/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))