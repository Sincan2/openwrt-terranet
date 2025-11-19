include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-terranet-dmz-pro
PKG_VERSION:=5.0
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_MAINTAINER:=TerraNet Indonesia

SECTION:=luci
CATEGORY:=LuCI
SUBMENU:=3. Applications

LUCI_TITLE:=TerraNet DMZ PRO v5 (nftables-native)
LUCI_DEPENDS:=+nftables +kmod-nft-nat +luci-base

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/lib/
	$(INSTALL_BIN) ./root/usr/lib/terranet_dmz_pro.sh $(1)/usr/lib/

	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) ./root/etc/init.d/terranet_dmz_pro $(1)/etc/init.d/

	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_CONF) ./root/etc/config/terranet_dmz_pro $(1)/etc/config/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller/
	$(INSTALL_DATA) ./luasrc/controller/terranet_dmz_pro.lua $(1)/usr/lib/lua/luci/controller/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/
	$(INSTALL_DATA) ./luasrc/model/cbi/terranet_dmz_pro.lua $(1)/usr/lib/lua/luci/model/cbi/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
