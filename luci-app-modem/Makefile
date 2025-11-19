# Copyright (C) 2023 Siriling <siriling@qq.com>
# This is free software, licensed under the GNU General Public License v3.

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-modem
LUCI_TITLE:=LuCI support for Modem
LUCI_PKGARCH:=all
PKG_VERSION:=1.4.4
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKF_MAINTAINER:=Siriling <siriling@qq.com>
LUCI_DEPENDS:=+luci-compat \
		+kmod-usb3 +kmod-usb-ohci \
		+kmod-usb-serial-option +kmod-usb-serial \
		+kmod-usb-net +kmod-usb-acm \
		+kmod-usb-wdm \
		+kmod-usb-net-cdc-ether +coreutils \
		+kmod-usb-net-cdc-mbim +coreutils-stat \
		+kmod-usb-net-rndis +usbutils \
		+kmod-usb-net-cdc-ncm +kmod-usb-net-huawei-cdc-ncm \
		+quectel-CM-5G \
		+pciutils \
		+sms-tool +grep +bc \
		+jq

define Package/luci-app-modem/conffiles
/etc/config/modem
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
