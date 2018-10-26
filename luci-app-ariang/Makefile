include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-ariang
PKG_VERSION:=2018-10-24

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/mayswind/AriaNg-DailyBuild
PKG_SOURCE_DATE:=2018-10-24
PKG_SOURCE_VERSION:=06f79b0b9372ad341fa26539b5b0efb48d322f66

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
    A luci app for ariang
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
	$(CP) \
		$(PKG_BUILD_DIR)/{langs,css,js,fonts} \
		$(PKG_BUILD_DIR)/index.html \
		$(PKG_BUILD_DIR)/index.manifest \
		$(PKG_BUILD_DIR)/LICENSE \
		$(PKG_BUILD_DIR)/favicon.ico \
		$(1)/www/web/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))