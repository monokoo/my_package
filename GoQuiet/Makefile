
include $(TOPDIR)/rules.mk

PKG_NAME:=gq-client
PKG_VERSION:=1.1.2
PKG_RELEASE:=1

ifeq ($(ARCH),i386)
	GQ_ARCH:=32
endif
ifeq ($(ARCH),x86_64)
	GQ_ARCH:=64
endif
ifeq ($(ARCH),arm)
	GQ_ARCH:=arm
endif
ifeq ($(ARCH),arm64)
	GQ_ARCH:=arm
endif

PKG_SOURCE_URL:=https://github.com/cbeuw/GoQuiet/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-linux$(GQ_ARCH)-$(PKG_VERSION)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)
PKG_HASH:=skip

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)

include $(INCLUDE_DIR)/package.mk

define Build/Prepare
	$(CP) $(TOPDIR)/dl/$(PKG_SOURCE) $(PKG_BUILD_DIR)/
endef

define Build/Compile
endef

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=GoQuiet Client
	URL:=https://github.com/cbeuw/GoQuiet/
endef

define Package/$(PKG_NAME)/description
	A shadowsocks plugin client that obfuscates the traffic as normal HTTPS traffic and disguises the proxy server as a normal webserver.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/$(PKG_SOURCE) $(1)/usr/bin/gq-client
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
