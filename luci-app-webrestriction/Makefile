include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-webrestriction
PKG_VERSION:=20170519
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=luci for webrestriction
        DEPENDS:=+libc
endef

define Package/$(PKG_NAME)/description
    A luci app for webrestriction, forked from koolshare Lede X64. Thanks to fw867.
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-webrestriction ]; then
		( . /etc/uci-defaults/luci-webrestriction ) && rm -f /etc/uci-defaults/luci-webrestriction
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

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/* $(1)/etc/uci-defaults/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/usr/share/control
	$(INSTALL_BIN) ./files/usr/share/control/* $(1)/usr/share/control/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/webrestriction
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/webrestriction/* $(1)/usr/lib/lua/luci/view/webrestriction/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/*.lua $(1)/usr/lib/lua/luci/model/cbi/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))