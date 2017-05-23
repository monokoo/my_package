include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-qosv4
PKG_VERSION:=20170523
PKG_RELEASE:=1

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for QoSV4
	DEPENDS:=+tc +iptables-mod-conntrack-extra +iptables-mod-filter +iptables-mod-imq +iptables-mod-ipopt +kmod-sched
endef

define Package/$(PKG_NAME)/description
	LuCI Support for QoSV4
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
	if [ -f /etc/uci-defaults/luci-qosv4 ]; then
		( . /etc/uci-defaults/luci-qosv4 ) && rm -f /etc/uci-defaults/luci-qosv4
	fi
	rm -rf /tmp/luci-indexcache
fi
exit 0
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/qosv4
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	
	$(INSTALL_BIN) ./files/etc/uci-defaults/luci-qosv4 $(1)/etc/uci-defaults/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/* $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/qosv4.lua $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/i18n/*.lmo $(1)/usr/lib/lua/luci/i18n/
	$(INSTALL_BIN) ./files/usr/bin/qosv4 $(1)/usr/bin/qosv4
	$(INSTALL_CONF) ./files/etc/config/qosv4 $(1)/etc/config/qosv4
	$(INSTALL_BIN) ./files/etc/init.d/qosv4 $(1)/etc/init.d/qosv4
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/* $(1)/etc/hotplug.d/iface/*


endef

$(eval $(call BuildPackage,$(PKG_NAME)))
