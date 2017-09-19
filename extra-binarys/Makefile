
include $(TOPDIR)/rules.mk

PKG_NAME:=extra-binarys
PKG_VERSION:=0.1
PKG_RELEASE:=20170919

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

define Package/extra-binarys/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_DIR) $(1)/usr/share/shadowsocks
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/kcpscript/kcpupdate $(1)/usr/share/shadowsocks/kcpupdate
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/kcpscript/addroute $(1)/usr/sbin/addroute
	
endef

$(eval $(call BuildPackage,extra-binarys))