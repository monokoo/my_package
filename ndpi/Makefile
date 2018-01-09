#http://www.ntop.org/
include $(TOPDIR)/rules.mk

PKG_NAME:=ndpi
PKG_RELEASE:=20170707

PKG_BUILD_DIR := $(BUILD_DIR)/$(PKG_NAME)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/uclibc++.mk
include $(INCLUDE_DIR)/package.mk


define Package/ndpi
  SECTION:=net
  CATEGORY:=Network
  TITLE:=ndpi
  DEPENDS:=+libjson-c +libpthread +libpcap +libc
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)
endef


define Build/Configure
	(cd $(PKG_BUILD_DIR)/ndpi; rm -f configure config.h config.h.in src/lib/Makefile.in ; autoreconf -ifv ;\
	./autogen.sh; \
	./configure --with-pic --host=$(GNU_TARGET_NAME);\
	);
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/ndpi
endef

define Package/ndpi/install
	$(INSTALL_DIR) $(1)/usr/lib $(1)/etc $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ndpi/src/lib/.libs/libndpi.so*  $(1)/usr/lib/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/ndpi/example/protos.txt $(1)/etc/protos.txt
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/ndpi/example/ndpiReader $(1)/usr/bin/ndpi
endef

$(eval $(call BuildPackage,ndpi))

