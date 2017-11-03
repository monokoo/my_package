include $(TOPDIR)/rules.mk

PKG_NAME:=serverchan
PKG_VERSION:=1.0
PKG_RELEASE=1

PKG_MAINTAINER:=monokoo

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/serverchan
	SECTION:=net
	CATEGORY:=Extra packages
	TITLE:=ServerChan
	DEPENDS:=+curl
endef

define Package/serverchan/description
serverchan is a tool for wechat
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/serverchan/conffiles
/etc/config/serverchan
endef

MAKE_FLAGS += -C $(PKG_BUILD_DIR)

define Package/serverchan/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d $(1)/etc/hotplug.d/dhcp $(1)/etc/config $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN)	$(PKG_BUILD_DIR)/serverchan $(1)/usr/bin/serverchan
	$(INSTALL_BIN)	$(PKG_BUILD_DIR)/serverchan_trigger $(1)/usr/bin/serverchan_trigger
	$(INSTALL_BIN) ./files/serverchan.init $(1)/etc/init.d/serverchan
	$(INSTALL_BIN) ./files/serverchan.hotplug-dhcp $(1)/etc/hotplug.d/dhcp/10-serverchan
	$(INSTALL_BIN) ./files/serverchan.hotplug-iface $(1)/etc/hotplug.d/iface/99-serverchan
	$(INSTALL_DATA) ./files/serverchan.config $(1)/etc/config/serverchan
	
endef

$(eval $(call BuildPackage,serverchan))
