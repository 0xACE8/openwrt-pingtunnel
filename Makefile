#
# Copyright (C) 2019-2023 0xACE7
#
# This is free software, This is free software, licensed under MIT.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=pingtunnel
PKG_VERSION:=2.7
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/esrrhs/$(PKG_NAME)/tar.gz/$(PKG_VERSION)?
PKG_HASH:=bd346e18998fde0f731023f58421251e4ef845225c94b194fb6413ad8d48ea68
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_MAINTAINER:=0xACE7
PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1

GO_PKG:=github.com/esrrhs/pingtunnel

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

GO_MOD_ARGS:=
GO_PKG_BUILD_VARS+= GO111MODULE=off

define Package/pingtunnel
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Pingtunnel is a tool that send TCP/UDP traffic over ICMP.
  URL:=https://github.com/esrrhs/pingtunnel
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/pingtunnel/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))

	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/sbin/
endef

define Package/pingtunnel/description
  Pingtunnel is a tool that send TCP/UDP traffic over ICMP.
endef


$(eval $(call GoBinPackage,pingtunnel))
$(eval $(call BuildPackage,pingtunnel))
