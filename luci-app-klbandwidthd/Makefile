include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-klbandwidthd
PKG_VERSION=20170801
PKG_RELEASE:=1
PKG_MAINTAINER:=Alex Zhuo <1886090@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=luci for klbandwidthd
	DEPENDS:=+klbandwidthd
endef

define Package/$(PKG_NAME)/description
    A luci app for klbandwidthd
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-bandwidthd ]; then
		( . /etc/uci-defaults/luci-bandwidthd ) && rm -f /etc/uci-defaults/luci-bandwidthd
	fi
	rm -rf /tmp/luci-indexcache
fi
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
	
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/luci-bandwidthd $(1)/etc/uci-defaults/luci-bandwidthd
	
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/99-bandwidthd $(1)/etc/hotplug.d/iface/99-bandwidthd
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/*.lua $(1)/usr/lib/lua/luci/model/cbi/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
