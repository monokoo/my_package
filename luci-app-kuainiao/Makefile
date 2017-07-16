
include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-kuainiao
PKG_VERSION:=20170716
PKG_RELEASE:=3

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-kuainiao
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
   DEPENDS:=+openssl-util +wget
   TITLE:=Xunlei Kuainiao Client for lede
endef

define Package/luci-app-kuainiao/description
endef

define Package/luci-app-kuainiao/conffiles
/etc/config/kuainiao
endef

define Build/Compile
endef

define Package/luci-app-kuainiao/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/usr/bin/* $(1)/usr/bin/
	$(INSTALL_BIN) ./files/etc/init.d/kuainiao $(1)/etc/init.d/
	$(INSTALL_CONF) ./files/etc/config/kuainiao $(1)/etc/config/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/* $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/*.lua $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/kuainiao
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/kuainiao/* $(1)/usr/lib/lua/luci/view/kuainiao/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/i18n/kuainiao.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/

	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/* $(1)/etc/hotplug.d/iface/
	$(INSTALL_DIR) $(1)/www/luci-static/resources
	$(INSTALL_DATA) ./files/js/* $(1)/www/luci-static/resources/
	
	$(INSTALL_DIR) $(1)/usr/share/kuainiao
	$(INSTALL_BIN) ./files/js/kuainiao_down_state $(1)/usr/share/kuainiao/kuainiao_down_state

endef


$(eval $(call BuildPackage,luci-app-kuainiao))
