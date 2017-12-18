
include $(TOPDIR)/rules.mk

PKG_NAME:=frpc
PKG_VERSION:=1.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/frpc
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Frpc
	URL:=https://github.com/fatedier/frp
	DEPENDS:=+libc
endef

define Build/Prepare
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
/etc/config/frpc
endef

define Package/frpc/install
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
	
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	
	$(INSTALL_DIR) $(1)/usr/bin
ifeq ($(ARCH),mipsel)
	$(INSTALL_BIN) ./files/bin/frpc_mipsle $(1)/usr/bin/frpc
endif
ifeq ($(ARCH),mips)
	$(INSTALL_BIN) ./files/bin/frpc_mips $(1)/usr/bin/frpc
endif
ifeq ($(ARCH),i386)
	$(INSTALL_BIN) ./files/bin/frpc_386 $(1)/usr/bin/frpc
endif
ifeq ($(ARCH),arm)
	$(INSTALL_BIN) ./files/bin/frpc_arm7 $(1)/usr/bin/frpc
endif
ifeq ($(ARCH),x86_64)
	$(INSTALL_BIN) ./files/bin/frpc_x86_64 $(1)/usr/bin/frpc
endif
	
endef

$(eval $(call BuildPackage,frpc))
