include $(TOPDIR)/rules.mk

PKG_NAME:=tproxy
PKG_VERSION:=1.3
PKG_RELEASE:=1

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Mitsuha <i@mitsuha.me>
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/tproxy
	SECTION:=Custom
	CATEGORY:=Extra packages
	TITLE:=TProxy for openwrt
	DEPENDS:=+luci-base +ip-full +PACKAGE_firewall4:kmod-nft-tproxy +PACKAGE_firewall:ipset +PACKAGE_firewall:kmod-ipt-tproxy +PACKAGE_firewall:iptables +PACKAGE_firewall:iptables-mod-tproxy
	PKGARCH:=all
endef

define Package/tproxy/description
	TProxy for openwrt.
endef

define Build/Compile
endef

define Package/tproxy/conffiles
/etc/config/tproxy
endef

define Package/tproxy/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/etc/config/
	$(INSTALL_BIN) ./files/tproxy.init $(1)/etc/init.d/tproxy
	$(INSTALL_CONF) ./files/tproxy.conf $(1)/etc/config/tproxy
ifdef CONFIG_PACKAGE_firewall
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) ./files/tproxy.fw3 $(1)/usr/bin/tproxy
endif
ifdef CONFIG_PACKAGE_firewall4
	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) ./files/tproxy.fw4 $(1)/usr/bin/tproxy
endif
endef

$(eval $(call BuildPackage,tproxy))
