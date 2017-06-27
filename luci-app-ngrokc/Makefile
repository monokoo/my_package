#
# Copyright (C) 2015-2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ngrokc
PKG_VERSION:=1.0
PKG_RELEASE:=3

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-ngrokc
	CATEGORY:=Network
	SUBMENU:=Luci
	TITLE:=LuCI support for ngrokc.
	PKGARCH:=all
	DEPENDS:=+ngrokc
endef


define Package/luci-app-cdns/description
	LuCI Support for cdns.
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/40_luci-ngrokc ]; then
		( . /etc/uci-defaults/40_luci-ngrokc ) && rm -f /etc/uci-defaults/40_luci-ngrokc
	fi
	rm -rf /tmp/luci-*
fi
exit 0
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/i18n/zh-cn/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.*.lmo $(1)/usr/lib/lua/luci/i18n/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/* $(1)/etc/uci-defaults/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/ngrokc
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/ngrokc/* $(1)/usr/lib/lua/luci/view/ngrokc/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/ngrokc
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/ngrokc/*.lua $(1)/usr/lib/lua/luci/model/cbi/ngrokc/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
