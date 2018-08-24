
include $(TOPDIR)/rules.mk

PKG_NAME:=v2ray
PKG_VERSION:=3.36
PKG_RELEASE:=1

ifeq ($(ARCH),mipsel)
	V2RAY_ARCH:=mipsle
endif
ifeq ($(ARCH),mips)
	V2RAY_ARCH:=mips
endif
ifeq ($(ARCH),i386)
	V2RAY_ARCH:=32
endif
ifeq ($(ARCH),x86_64)
	V2RAY_ARCH:=64
endif
ifeq ($(ARCH),arm)
	V2RAY_ARCH:=arm
endif
ifeq ($(ARCH),arm64)
	V2RAY_ARCH:=arm64
endif

PKG_LICENSE:=Apache-2.0

PKG_SOURCE_URL:=https://github.com/v2ray/v2ray-core/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=v2ray-linux-$(V2RAY_ARCH).zip
PKG_BUILD_DIR:=$(BUILD_DIR)/v2ray_$(PKG_VERSION)_linux_$(V2RAY_ARCH)
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/v2ray
	SECTION:=net
	CATEGORY:=Network
	TITLE:=V2ray is a platform for building proxies to bypass network restrictions. 
	URL:=https://github.com/v2ray/v2ray-core
	DEPENDS:=
endef

define Build/Prepare
	$(PKG_UNPACK)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/v2ray/description
A platform for building proxies to bypass network restrictions.
endef

define Package/v2ray/postinst

endef

define Package/v2ray/conffiles
endef

define Package/v2ray/install
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/v2ray $(1)/usr/bin/v2ray

endef

$(eval $(call BuildPackage,v2ray))
