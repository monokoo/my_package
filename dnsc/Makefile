include $(TOPDIR)/rules.mk

PKG_NAME:=dnsc
PKG_VERSION:=1.0.0
PKG_RELEASE:=2

#PKG_SOURCE_PROTO:=git
#PKG_SOURCE_URL:=https://github.com/fangdingjun/dnsproxy
#PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
#PKG_SOURCE_VERSION:=HEAD
#PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

include $(INCLUDE_DIR)/package.mk

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/dnsc
        SECTION:=net
        CATEGORY:=Network
        TITLE:=a dns proxy server
        URL:=https://github.com/fangdingjun/dnsproxy
endef


define Package/dnsc/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/dnsc
	$(INSTALL_BIN) ./files/dnsproxy $(1)/usr/bin/dnsc
	$(INSTALL_DATA) ./files/iplist.txt $(1)/etc/dnsc/
endef

$(eval $(call BuildPackage,dnsc))
