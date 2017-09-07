include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ariang
PKG_VERSION:=20170903
PKG_RELEASE:=0bf8c72

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=luci for ariang
        DEPENDS:=+luci-i18n-aria2-zh-cn +luci-app-aria2 +aria2
endef

define Package/$(PKG_NAME)/description
    A luci app for ariang, forked from koolshare Lede X64. Thanks to fw867.
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

	$(INSTALL_DIR) $(1)/www/web
	$(CP) -r ./files/www/web/* $(1)/www/web/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))