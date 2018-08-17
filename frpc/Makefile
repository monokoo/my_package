
include $(TOPDIR)/rules.mk

PKG_NAME:=frpc
PKG_VERSION:=0.21.0
PKG_RELEASE:=1

ifeq ($(ARCH),mipsel)
	FRPC_ARCH:=mipsle
endif
ifeq ($(ARCH),mips)
	FRPC_ARCH:=mips
endif
ifeq ($(ARCH),i386)
	FRPC_ARCH:=386
endif
ifeq ($(ARCH),x86_64)
	FRPC_ARCH:=amd64
endif
ifeq ($(ARCH),arm)
	FRPC_ARCH:=arm
endif
ifeq ($(ARCH),arm64)
	FRPC_ARCH:=arm64
endif

PKG_LICENSE:=Apache-2.0

PKG_SOURCE_URL:=https://github.com/fatedier/frp/releases/download/v$(PKG_VERSION)
PKG_SOURCE:=frp_$(PKG_VERSION)_linux_$(FRPC_ARCH).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/frp_$(PKG_VERSION)_linux_$(FRPC_ARCH)
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/frpc
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Frpc
	URL:=https://github.com/fatedier/frp
	DEPENDS:=+libc
endef

define Build/Prepare
	$(PKG_UNPACK)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/frpc/description
frpc is efficient internal network penetration tool
endef

define Package/frpc/postinst

endef

define Package/frpc/conffiles
/etc/config/frp
endef

define Package/frpc/install
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/frpc $(1)/usr/bin/frpc

	
endef

$(eval $(call BuildPackage,frpc))
