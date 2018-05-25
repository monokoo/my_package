include $(TOPDIR)/rules.mk

PKG_NAME:=dnsc
PKG_VERSION:=1.0.0
PKG_RELEASE:=4

include $(INCLUDE_DIR)/package.mk

define Package/dnsc
        SECTION:=net
        CATEGORY:=Network
        TITLE:=A simple DNS proxy server
        URL:=https://github.com/fangdingjun/dnsproxy
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/dnsc/description
A simple DNS proxy server
endef

define Package/dnsc/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/dnsc
	$(INSTALL_DATA) ./files/iplist.txt $(1)/etc/dnsc/
ifeq ($(BUILD_DIR),/home/lede/lede-source/build_dir/target-arm_cortex-a15+neon-vfpv4_musl_eabi)
	$(INSTALL_BIN) ./files/dnsc-r7800 $(1)/usr/bin/dnsc
endif
ifeq ($(BUILD_DIR),/home/lede/lede-source/build_dir/target-arm_cortex-a9_musl_eabi)
	$(INSTALL_BIN) ./files/dnsc-k3 $(1)/usr/bin/dnsc
endif

endef

$(eval $(call BuildPackage,dnsc))
