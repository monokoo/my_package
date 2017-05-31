include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-softethervpn
PKG_VERSION:=20170531
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for softethervpn by fw8678
	DEPENDS:=+softethervpn
endef

define Package/$(PKG_NAME)/description
	LuCI Support for softethervpn by fw8678
endef

define Build/Prepare
endef


define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-softethervpn ]; then
		( . /etc/uci-defaults/luci-softethervpn ) && rm -f /etc/uci-defaults/luci-softethervpn
	fi
	rm -rf /tmp/luci-indexcache
fi
exit 0
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/softethervpn
	
	$(INSTALL_BIN) ./files//etc/uci-defaults/luci-softethervpn $(1)/etc/uci-defaults/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/* $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/softethervpn.lua $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/softethervpn/* $(1)/usr/lib/lua/luci/view/softethervpn/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
