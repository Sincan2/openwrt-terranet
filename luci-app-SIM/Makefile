# Copyright (C) 2023 Siriling <siriling@qq.com>
# This is free software, licensed under the GNU General Public License v3.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-sim
LUCI_TITLE:=LuCI support for sim
LUCI_PKGARCH:=all
PKG_VERSION:=1.4.4
PKG_LICENSE:=GPLv3
PKG_LINCESE_FILES:=LICENSE
PKF_MAINTAINER:=Siriling <siriling@qq.com>
LUCI_DEPENDS:=+libc 

define Package/luci-app-SIM/conffiles
/etc/config/modem_sim
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
