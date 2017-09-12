
include $(TOPDIR)/rules.mk

PKG_NAME:=ddnsto
PKG_VERSION:=0.2.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/ddnsto
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Ddnsto
	URL:=https://www.ddns.to
	DEPENDS:=+libc
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/ddnsto/description
ddnsto is efficient internal network penetration tool
endef

define Package/ddnsto/postinst

endef

define Package/ddnsto/conffiles
/etc/config/ddnsto
endef

define Package/ddnsto/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/* $(1)/usr/bin/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	
endef

$(eval $(call BuildPackage,ddnsto))
