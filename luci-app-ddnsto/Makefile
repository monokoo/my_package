include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ddnsto
PKG_VERSION:=20170809
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=luci for ddnsto
endef

define Package/$(PKG_NAME)/description
    A luci app for ddnsto, forked from koolshare Lede X64. Thanks to fw867.
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/40_luci-ddnsto ]; then
		( . /etc/uci-defaults/40_luci-ddnsto ) && rm -f /etc/uci-defaults/40_luci-ddnsto
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
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
	$(INSTALL_BIN) ./files/etc/uci-defaults/40_luci-ddnsto $(1)/etc/uci-defaults/40_luci-ddnsto
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/ddnsto
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/ddnsto/* $(1)/usr/lib/lua/luci/model/cbi/ddnsto/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/ddnsto
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/ddnsto/* $(1)/usr/lib/lua/luci/view/ddnsto/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))