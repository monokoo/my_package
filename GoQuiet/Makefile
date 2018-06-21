#
# Copyright (C) 2018 Andrea Muratori <andrea.m4niac@gmail.com>
#
# This is free software, licensed under the GNU General Public License v3.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=GoQuiet
PKG_VERSION:=1.0.0
PKG_RELEASE:=2

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/cbeuw/GoQuiet.git
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_RELEASE)
PKG_SOURCE_VERSION:=a86ad43241e303ef4cc13abc6975b210d8a33ea2
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Andrea Muratori <andrea.m4niac@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)/$(PKG_SOURCE_SUBDIR)

include $(INCLUDE_DIR)/package.mk

define Package/GoQuiet/Default
	SECTION:=net
	CATEGORY:=Network
	TITLE:=GoQuiet
	URL:=https://github.com/cbeuw/GoQuiet/
endef

Package/GoQuiet-client = $(call Package/GoQuiet/Default)
Package/GoQuiet-server = $(call Package/GoQuiet/Default)

define Package/GoQuiet-client/description
A shadowsocks plugin that obfuscates the traffic as normal HTTPS traffic and disguises the proxy server as a normal webserver.
endef

Package/GoQuiet-server/description = $(Package/GoQuiet-client/description)

CONFIGURE_ARGS += --disable-ssp --disable-documentation --disable-assert

define Package/GoQuiet-client/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/gq-client $(1)/usr/bin/gq-client
endef

define Package/GoQuiet-server/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build/gq-server $(1)/usr/bin/gq-server
endef

$(eval $(call BuildPackage,GoQuiet-client))
$(eval $(call BuildPackage,GoQuiet-server))