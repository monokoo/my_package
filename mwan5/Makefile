#
# Copyright (C) 2006-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mwan5
PKG_VERSION:=3.7.0
PKG_RELEASE:=4
PKG_MAINTAINER:=Florian Eckert <fe@dev.tdt.de>
PKG_LICENSE:=GPLv2

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
   SECTION:=net
   CATEGORY:=Network
   SUBMENU:=Routing and Redirection
   DEPENDS:=+ip-full +ipset +iptables +iptables-mod-conntrack-extra +iptables-mod-ipopt +jshn
   TITLE:=Multiwan hotplug script with connection tracking support
   MAINTAINER:=Florian Eckert <fe@dev.tdt.de>
   PKGARCH:=all
endef

define Package/$(PKG_NAME)/description
Hotplug script which makes configuration of multiple WAN interfaces simple
and manageable. With loadbalancing/failover support for up to 250 wan
interfaces, connection tracking and an easy to manage traffic ruleset.
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/mwan3
/etc/mwan3.user
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/rpcd restart
fi
exit 0
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	/etc/init.d/rpcd restart
fi
exit 0
endef

define Package/$(PKG_NAME)/install

	$(INSTALL_DIR) $(1)/etc/config $(1)/etc/init.d
	$(INSTALL_CONF) ./files/etc/config/mwan3 $(1)/etc/config/mwan3
	$(INSTALL_BIN) ./files/etc/init.d/mwan3 $(1)/etc/init.d/mwan3
	
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) ./files/etc/mwan3.user $(1)/etc/mwan3.user

	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/14-mwan3 $(1)/etc/hotplug.d/iface/14-mwan3
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/15-mwan3 $(1)/etc/hotplug.d/iface/15-mwan3
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/16-mwan3 $(1)/etc/hotplug.d/iface/16-mwan3
	$(INSTALL_BIN) ./files/etc/hotplug.d/iface/16-mwan3-user $(1)/etc/hotplug.d/iface/16-mwan3-user

	$(INSTALL_DIR) $(1)/lib/mwan3
	$(INSTALL_BIN) ./files/lib/mwan3/* $(1)/lib/mwan3/

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/usr/sbin/* $(1)/usr/sbin/

	$(INSTALL_DIR) $(1)/usr/libexec/rpcd
	$(INSTALL_BIN) ./files/usr/libexec/rpcd/* $(1)/usr/libexec/rpcd/
	
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
