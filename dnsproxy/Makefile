include $(TOPDIR)/rules.mk

PKG_NAME:=dnsproxy
PKG_VERSION:=1.1.1
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/monokoo/dnsproxy.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=843b8152b27657bad714816571759f6764a6a353
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Package/dnsproxy
        SECTION:=net
        CATEGORY:=Network
        TITLE:=A simple DNS proxy server
        URL:=https://github.com/vietor/dnsproxy
endef



define Package/dnsproxy/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/dnsproxy $(1)/usr/bin
endef

$(eval $(call BuildPackage,dnsproxy))
