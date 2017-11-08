include $(TOPDIR)/rules.mk

PKG_NAME:=dnsc
PKG_VERSION:=1.0.0
PKG_RELEASE:=4

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/fangdingjun/dnsproxy
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=9f4b250ede408979126db26ed6d0f5ce8773a025
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/dnsc
        SECTION:=net
        CATEGORY:=Network
        TITLE:=A simple DNS proxy server
        URL:=https://github.com/fangdingjun/dnsproxy
endef

define Package/dnsc/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/dnsc
	$(INSTALL_DATA) ./files/iplist.txt $(1)/etc/dnsc/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/dnsproxy $(1)/usr/bin/dnsc
endef

$(eval $(call BuildPackage,dnsc))
