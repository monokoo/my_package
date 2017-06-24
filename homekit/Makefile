#
# Copyright (C) 2015 OpenWrt-dist
# Copyright (C) 2016 fw867 <ffkykzs@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=homekit
PKG_VERSION:=20170625
PKG_RELEASE:=2


PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/etwmc/WiFi-RadarHAP.git
PKG_SOURCE_VERSION:=HEAD
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_USE_MIPS16:=0
PKG_FIXUP:=autoreconf
include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=This is a HomeKit support accessories.
	DEPENDS:=@!LINUX_2_4 +libavahi-compat-libdnssd +libopenssl +libstdcpp +libpthread +libc
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/homekit
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
# check if we are on real system
if [ -z "$${IPKG_INSTROOT}" ]; then
	echo "Enabling rc.d symlink for homekit"
	/etc/init.d/homekit enable
fi
exit 0
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/PHK $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
