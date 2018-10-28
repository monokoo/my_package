include $(TOPDIR)/rules.mk

PKG_NAME:=json2pb
PKG_VERSION:=1.0
PKG_RELEASE:=1


include $(INCLUDE_DIR)/package.mk

define Package/json2pb
  CATEGORY:=Utilities
  TITLE:=json2pb
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Package/json2pb/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/json2pb $(1)/usr/bin
endef


$(eval $(call BuildPackage,json2pb))
