#
# Copyright (C) 2007-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libavahi-compat-libdnssd-dev
PKG_VERSION:=0.6.32
PKG_RELEASE:=2

PKG_MAINTAINER:=Ted Hess <thess@kitschensync.net>

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libavahi-compat-libdnssd-dev
  $(call Package/avahi/Default)
  SECTION:=libs
  CATEGORY:=Libraries
  VARIANT:=dbus
  DEPENDS:=+libavahi-client
  TITLE+= (libdnssd-dev)
endef

define Package/libavahi-compat-libdnssd-dev/description
 This packages adds the libavahi-compat-libdnssd-dev library.
 It also automatically adds the required libavahi-client package.
 For more information please see the avahi documentation.
endef

define Package/libavahi-compat-libdnssd-dev/install
	$(INSTALL_DIR) $(1)/usr/include
	$(INSTALL_DATA) ./files/dns_sd.h $(1)/usr/include/dns_sd.h
endef

$(eval $(call BuildPackage,libavahi-compat-libdnssd-dev))
