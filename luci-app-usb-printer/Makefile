include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-usb-printer
PKG_VERSION:=20170712
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
#PKG_USE_MIPS16:=0

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	PKGARCH:=all
	TITLE:=USB Printer Share via TCP/IP
        DEPENDS:=+p910nd
endef

define Package/$(PKG_NAME)/description
    A luci app for usb-printer
endef

define Package/$(PKG_NAME)/preinst
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	if [ -f /etc/uci-defaults/luci-usb-printer ]; then
		( . /etc/uci-defaults/luci-usb-printer ) && rm -f /etc/uci-defaults/luci-usb-printer
	fi
	rm -rf /tmp/luci-indexcache
fi
exit 0
endef

define Build/Prepare
	$(foreach po,$(wildcard ${CURDIR}/files/i18n/*.po), \
		po2lmo $(po) $(PKG_BUILD_DIR)/$(patsubst %.po,%.lmo,$(notdir $(po)));)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/usb_printer
endef

define Package/$(PKG_NAME)/install

	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/* $(1)/etc/config/
	
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/etc/uci-defaults/* $(1)/etc/uci-defaults/
	
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/* $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/hotplug.d/usb
	$(INSTALL_BIN) ./files/etc/hotplug.d/usb/* $(1)/etc/hotplug.d/usb/

	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) ./files/usr/bin/detectlp $(1)/usr/bin/detectlp
	$(INSTALL_BIN) ./files/usr/bin/usb_printer_hotplug $(1)/usr/bin/usb_printer_hotplug

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/i18n
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/usb-printer.zh-cn.lmo $(1)/usr/lib/lua/luci/i18n/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./files/luasrc/controller/*.lua $(1)/usr/lib/lua/luci/controller/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/webrecord
	$(INSTALL_DATA) ./files/usr/lib/lua/luci/view/webrecord/* $(1)/usr/lib/lua/luci/view/webrecord/
	
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./files/luasrc/model/cbi/*.lua $(1)/usr/lib/lua/luci/model/cbi/

endef

$(eval $(call BuildPackage,$(PKG_NAME)))