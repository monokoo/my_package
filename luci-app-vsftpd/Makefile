include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-vsftpd
PKG_VERSION=1.0
PKG_RELEASE:=1
PKG_MAINTAINER:=穿越蓝天 < admin@nvacg.com >

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=Luci
	SUBMENU:=3. Applications
	TITLE:=luci for vsftpd
	DEPENDS:=+vsftpd
endef

define Package/$(PKG_NAME)/description
    A luci app for vsftpd for FTP
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
rm -rf /tmp/luci*
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/i18n/zh_CN/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/vsftpd
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/*.*.lmo $(1)/usr/lib/lua/luci/i18n/
	$(CP) ./files/* $(1)/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
