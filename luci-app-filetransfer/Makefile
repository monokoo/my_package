include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-filetransfer
PKG_VERSION:=20170905
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=luci for filetransfer
        DEPENDS:=+libc
endef

define Package/$(PKG_NAME)/description
    LuCI Support for filetransfer by fw867
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/i18n/filetransfer.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/fs.lua $(1)/usr/lib/lua/luci/fs.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/*.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/*.lua $(1)/usr/lib/lua/luci/model/cbi/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/cbi
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/cbi/* $(1)/usr/lib/lua/luci/view/cbi/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
