
include $(TOPDIR)/rules.mk

PKG_NAME:=easyexplorer
PKG_VERSION:=0.1.3
PKG_RELEASE:=beta

include $(INCLUDE_DIR)/package.mk

define Package/easyexplorer
	SECTION:=net
	CATEGORY:=Network
	TITLE:=easyexplorer
	URL:=https://www.ddns.to
	DEPENDS:=+libc
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/easyexplorer/description
easyexplorer is efficient files sync tool
endef

define Package/easyexplorer/postinst

endef

define Package/easyexplorer/conffiles
/etc/config/easyexplorer
endef

define Package/easyexplorer/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/* $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	
endef

$(eval $(call BuildPackage,easyexplorer))
