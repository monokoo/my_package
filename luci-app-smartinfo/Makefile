include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-smartinfo
PKG_VERSION:=3.1
PKG_RELEASE:=2

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=LuCI Support for smartinfo
	DEPENDS:=+smartmontools
endef

define Package/$(PKG_NAME)/description
	LuCI Support for smartinfo
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef


define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/33_luci-smartinfo ]; then
		( . /etc/uci-defaults/33_luci-smartinfo ) && rm -f /etc/uci-defaults/33_luci-smartinfo
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/smartinfo
endef

define Package/$(PKG_NAME)/install

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/root/etc/uci-defaults/33_luci-smartinfo $(1)/etc/uci-defaults/33_luci-smartinfo

	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller $(1)/usr/lib/lua/luci/view/admin_status
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/smartinfo $(1)/usr/lib/lua/luci/view/admin_status/index
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n $(1)/usr/lib/smartinfo
	
	$(INSTALL_CONF) ./files/root/etc/config/* $(1)/etc/config/
	$(INSTALL_BIN) ./files/root/etc/init.d/* $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/root/usr/lib/smartinfo/* $(1)/usr/lib/smartinfo/
	$(INSTALL_DATA) ./files/luasrc/model/cbi/* $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DATA) ./files/luasrc/controller/* $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DATA) ./files/luasrc/view/smartinfo/* $(1)/usr/lib/lua/luci/view/smartinfo/
	$(INSTALL_DATA) ./files/luasrc/view/admin_status/index/* $(1)/usr/lib/lua/luci/view/admin_status/index/
	$(INSTALL_DATA) ./files/luasrc/view/admin_status/disc_status.htm $(1)/usr/lib/lua/luci/view/admin_status/disc_status.htm
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/smartinfo.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
