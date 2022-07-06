include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-tproxy
PKG_VERSION:=3.4
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Mitsuha <i@mitsuha.me>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-tproxy
	SECTION:=Custom
	CATEGORY:=Extra packages
	TITLE:=tproxy for openwrt
	DEPENDS:=+luci-base +ip-full +PACKAGE_firewall4:kmod-nft-tproxy +PACKAGE_firewall:ipset +PACKAGE_firewall:kmod-ipt-tproxy +PACKAGE_firewall:iptables +PACKAGE_firewall:iptables-mod-tproxy
	PKGARCH:=all
endef

define Package/luci-app-tproxy/description
	Easy set transparent proxy for openwrt.
endef

define Build/Compile
endef

define Package/luci-app-tproxy/conffiles
/etc/config/tproxy
endef

define Package/luci-app-tproxy/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d/
	$(INSTALL_DIR) $(1)/usr/share/luci/menu.d/
	$(INSTALL_DIR) $(1)/www/luci-static/resources/view/network/
	$(INSTALL_BIN) ./files/tproxy.init $(1)/etc/init.d/tproxy
	$(INSTALL_CONF) ./files/tproxy.conf $(1)/etc/config/tproxy
	$(INSTALL_CONF) ./files/tproxy.acl $(1)/usr/share/rpcd/acl.d/luci-app-tproxy.json
	$(INSTALL_CONF) ./files/tproxy.menu $(1)/usr/share/luci/menu.d/luci-app-tproxy.json
	$(INSTALL_CONF) ./files/tproxy.js $(1)/www/luci-static/resources/view/network/tproxy.js
ifdef CONFIG_PACKAGE_firewall
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) ./files/tproxy.fw3 $(1)/usr/bin/tproxy
endif
ifdef CONFIG_PACKAGE_firewall4
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) ./files/tproxy.fw4 $(1)/usr/bin/tproxy
endif
endef

$(eval $(call BuildPackage,luci-app-tproxy))
