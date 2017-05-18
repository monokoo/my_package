include $(TOPDIR)/rules.mk

PKG_NAME:=koolpbr
PKG_VERSION:=1.0-1
PKG_RELEASE:=1
PKG_MAINTAINER:=fw867 <ffkykzs@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=net
	TITLE:=koolpbr
        DEPENDS:=+libc
endef

define Package/$(PKG_NAME)/description
    Multiple ISP Policy Routes, forked from koolshare Lede X64. Thanks to fw867.
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

	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/koolpbr $(1)/etc/init.d/koolpbr
	
	$(INSTALL_DIR) $(1)/etc/config/koolpbr
	$(INSTALL_CONF) ./files/etc/config/koolpbr $(1)/etc/config/koolpbr
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/* $(1)/usr/bin/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
