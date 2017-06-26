include $(TOPDIR)/rules.mk

PKG_NAME:=dnsc
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/awaw/dnsproxy
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=HEAD
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/dnsc
        SECTION:=net
        CATEGORY:=Network
        TITLE:=a dns proxy server
        URL:=https://github.com/fangdingjun/dnsproxy
	DEPENDS:=+libevent2
endef


define Package/dnsc/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/dnsproxy $(1)/usr/bin/dnsc
endef

$(eval $(call BuildPackage,dnsc))
