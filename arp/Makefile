include $(TOPDIR)/rules.mk

PKG_NAME:=arp
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/huih/arp.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=c765a7d0c592271405aa513f58accf9026149a20
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/arp
        SECTION:=net
        CATEGORY:=Network
        TITLE:=The project have send arp package and recv arp package functional, furthermore query machine ip ,mac, netmask,broadcast, other machine mac.
        URL:=https://github.com/huih/arp
endef

define Package/arp/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/dnsproxy $(1)/usr/bin/
endef

$(eval $(call BuildPackage,arp))
