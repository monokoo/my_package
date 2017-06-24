include $(TOPDIR)/rules.mk

PKG_NAME:=libavahi-compat-libdnssd-dev
PKG_VERSION:=0.6.32
PKG_RELEASE:=2
PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=libs
	CATEGORY:=Libraries
	TITLE:=libavahi-compat-libdnssd-dev library	
        DEPENDS:=+libavahi-client
endef

define Package/$(PKG_NAME)/description
	This packages adds the libavahi-compat-libdnssd-dev library.
	It also automatically adds the required libavahi-client package.
	For more information please see the avahi documentation.
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	cd /usr/lib
	ln -s libdns_sd.so.1.0.0 libdns_sd.so
	ln -s libavahi-client.so.3.2.9 libavahi-client.so
fi
exit 0
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

	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DATA) ./files/dns_sd.h $(1)/usr/include/dns_sd.h
	$(INSTALL_DATA) ./files/client.h $(1)/usr/include/client.h
	$(INSTALL_DATA) ./files/lookup.h $(1)/usr/include/lookup.h
	$(INSTALL_DATA) ./files/publish.h $(1)/usr/include/publish.h
	
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(INSTALL_DATA) ./files/avahi-client.pc $(1)/usr/lib/pkgconfig/avahi-client.pc
	$(INSTALL_DATA) ./files/avahi-compat-libdns_sd.pc $(1)/usr/lib/pkgconfig/avahi-compat-libdns_sd.pc

endef

$(eval $(call BuildPackage,$(PKG_NAME)))
