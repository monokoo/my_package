include $(TOPDIR)/rules.mk

PKG_NAME:=geoip
PKG_VERSION:=20170911
PKG_RELEASE:=1

PKG_MAINTAINER:=monokoo <realstones2012@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Geoip
endef

define Package/$(PKG_NAME)/description
    Geographic information for IP addresses.
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
endef

define Package/$(PKG_NAME)/prerm
endef

define Package/$(PKG_NAME)/postrm
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
endef

define Package/$(PKG_NAME)/install

	$(INSTALL_DIR) $(1)/usr/share/xt_geoip
	$(CP) -R ./files/usr/share/xt_geoip/* $(1)/usr/share/xt_geoip/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))