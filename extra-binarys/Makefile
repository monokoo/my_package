
include $(TOPDIR)/rules.mk

PKG_NAME:=extra-binarys
PKG_VERSION:=0.3
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)

include $(INCLUDE_DIR)/package.mk

define Package/extra-binarys
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=extra binarys for my packages
	DEPENDS:=+libc
endef

define Package/extra-binarys/description
Extra binarys for my packages
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
        if [ -f /etc/uci-defaults/99-optimization-settings ]; then
                ( . /etc/uci-defaults/99-optimization-settings ) && rm -f /etc/uci-defaults/99-optimization-settings
        fi
        rm -rf /tmp/luci-indexcache
fi
exit 0
endef

define Package/extra-binarys/install
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/optimization-settings $(1)/etc/uci-defaults/99-optimization-settings
	$(INSTALL_DIR) $(1)/www/luci-static/argon/js
	$(INSTALL_DATA) ./files/polyfill.min.js $(1)/www/luci-static/argon/js/polyfill.min.js
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/share/shadowsocks
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/kcpupdate $(1)/usr/share/shadowsocks/kcpupdate
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/v2update $(1)/usr/share/shadowsocks/v2update
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/addroute $(1)/usr/sbin/addroute
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/syncthingready $(1)/usr/sbin/syncthingready
	
endef

$(eval $(call BuildPackage,extra-binarys))
