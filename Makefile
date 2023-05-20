# SPDX-License-Identifier: MIT
#
# Copyright (c) 2017 Yu Wang <wangyucn@gmail.com>

include $(TOPDIR)/rules.mk

PKG_NAME:=pingtunnel
PKG_VERSION:=20230206.0
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/wangyu-/pingtunnel/tar.gz/$(PKG_VERSION)?
PKG_HASH:=1e459020654d3c65acb252a56fe11a5e2feec5a64d6e2ffd0aacc14213bbc9c0

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Yu Wang

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/pingtunnel
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Tunnel which turns UDP Traffic into Encrypted Traffic
  URL:=https://github.com/wangyu-/pingtunnel
  DEPENDS:=+libstdcpp +libpthread +librt
  PROVIDES:=pingtunnel-tunnel
endef

define Package/pingtunnel/description
  pingtunnel-tunnel is a tunnel which turns UDP Traffic into Encrypted FakeTCP/UDP/ICMP Traffic by using Raw Socket.
endef

MAKE_FLAGS += cross

define Build/Prepare
	$(PKG_UNPACK)
	sed -i 's/cc_cross=.*/cc_cross=$(TARGET_CXX)/g' $(PKG_BUILD_DIR)/makefile
	sed -i '/\*gitversion/d' $(PKG_BUILD_DIR)/makefile
	echo 'const char *gitversion = "$(PKG_VERSION)";' > $(PKG_BUILD_DIR)/git_version.h
	$(Build/Patch)
endef

define Package/pingtunnel/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/pingtunnel_cross $(1)/usr/bin/pingtunnel
endef

$(eval $(call BuildPackage,pingtunnel))
