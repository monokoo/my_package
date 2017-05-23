include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-qos-guoguo
PKG_VERSION:=0.0.2
PKG_RELEASE:=2

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for QoS scripts by GuoGuo
	DEPENDS:=+qos-guoguo
endef

define Package/$(PKG_NAME)/description
	LuCI Support for QoS scripts by GuoGuo
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
	if [ -f /etc/uci-defaults/luci-qos_guoguo ]; then
		( . /etc/uci-defaults/luci-qos_guoguo ) && rm -f /etc/uci-defaults/luci-qos_guoguo
	fi
	rm -rf /tmp/luci-indexcache
fi
exit 0
endef


define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/qos_guoguo
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/qos_guoguo
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	
	$(INSTALL_BIN) ./files//etc/uci-defaults/luci-qos_guoguo $(1)/etc/uci-defaults/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/qos_guoguo/* $(1)/usr/lib/lua/luci/model/cbi/qos_guoguo/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/qos_guoguo.lua $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/qos_guoguo/* $(1)/usr/lib/lua/luci/view/qos_guoguo/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/i18n/*.lmo $(1)/usr/lib/lua/luci/i18n/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
