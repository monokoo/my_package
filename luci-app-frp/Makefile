include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-frp
PKG_VERSION:=2.0
PKG_RELEASE:=1

PKG_MAINTAINER:=monokoo <realstones2012@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=luci for Frp by monokoo
        DEPENDS:=+libc +frpc
endef

define Package/$(PKG_NAME)/description
    A luci app for Frp by monokoo
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-frp ]; then
		( . /etc/uci-defaults/luci-frp ) && rm -f /etc/uci-defaults/luci-frp
	fi
	rm -rf /tmp/luci-indexcache /tmp/luci-modulecache
fi
exit 0
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
endef

define Package/$(PKG_NAME)/install
	
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/luci-frp $(1)/etc/uci-defaults/luci-frp
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/frp.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/frp
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/frp/*.lua $(1)/usr/lib/lua/luci/model/cbi/frp/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/frp
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/frp/* $(1)/usr/lib/lua/luci/view/frp/
	
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
