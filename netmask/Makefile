include $(TOPDIR)/rules.mk

PKG_NAME:=netmask
PKG_VERSION:=2.4.3
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/tlby/netmask.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=ccb757d7b22b40a9458f8d12ad7041549f2ae539
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz


PKG_INSTALL:=1
PKG_FIXUP:=autoreconf
PKG_USE_MIPS16:=0
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/netmask
        SECTION:=net
        CATEGORY:=Network
        TITLE:=This is a handy tool for generating terse netmasks in several common formats.
        URL:=https://github.com/tlby/netmask
endef



define Package/netmask/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/netmask $(1)/usr/bin/
endef

$(eval $(call BuildPackage,netmask))
