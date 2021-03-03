#!/bin/bash
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# 基本不需要添加啥插件了,我搜集了各位大神的插件都集成一个软件包直接打入源码里面了
# 要了解增加了什么东西，就到我的专用软件包里面看看看吧，如果还是没有你需要的插件，请不要一下子就拉取别人的插件包
# 相同的文件都拉一起，因为有一些可能还是其他大神修改过的容易造成编译错误的
# 想要什么插件就单独的拉取什么插件就好，或者告诉我，我把插件放我的插件包就行了
# 软件包地址：https://github.com/281677160/openwrt-package
# 拉取插件请看《各种命令的简单介绍》第4条、第5条说明,不管大神还是新手请认真的看看,再次强调请不要一下子就拉取别人一堆插件的插件包,容易造成编译错误的

# Add luci-app-ssr-plus
pushd package/lean
git clone --depth=1 https://github.com/fw876/helloworld
popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

# Add Lienol's Packages
git clone --depth=1 https://github.com/Lienol/openwrt-package

# Add luci-app-passwall
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall

# Add luci-app-vssr <M>
git clone --depth=1 https://github.com/jerrykuku/lua-maxminddb.git
git clone --depth=1 https://github.com/jerrykuku/luci-app-vssr

# Add mentohust & luci-app-mentohust
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust
git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash

# Add luci-app-onliner (need luci-app-nlbwmon)
git clone --depth=1 https://github.com/rufengsuixing/luci-app-onliner

# Add luci-app-adguardhome
svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-app-adguardhome

# Add luci-app-diskman
git clone --depth=1 https://github.com/SuLingGG/luci-app-diskman
mkdir parted
cp luci-app-diskman/Parted.Makefile parted/Makefile

# Add luci-app-dockerman
rm -rf ../lean/luci-app-docker
git clone --depth=1 https://github.com/KFERMercer/luci-app-dockerman
git clone --depth=1 https://github.com/lisaac/luci-lib-docker

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config
rm -rf ../lean/luci-theme-argon


# Add subconverter
git clone --depth=1 https://github.com/tindy2013/openwrt-subconverter

# Add smartdns
rm -rf smartdns
rm -rf luci-app-smartdns
git clone --depth=1 https://github.com/pymumu/smartdns
git clone --depth=1 -b lede https://github.com/pymumu/luci-app-smartdns
rm -rf ../lean/smartdns
rm -rf ../lean/luci-app-smartdns

# Add baiduPcsWeb
#https://github.com/immortalwrt/immortalwrt/tree/openwrt-21.02/package/ctcgfw/baidupcs-web
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/ctcgfw/baidupcs-web
svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/ctcgfw/luci-app-baidupcs-web
rm -rf ../lean/baidupcs-web
rm -rf ../lean/luci-app-baidupcs-web

# Add luci-udptools
git clone --depth=1 https://github.com/zcy85611/openwrt-luci-kcp-udp

# Add OpenAppFilter
git clone --depth=1 https://github.com/destan19/OpenAppFilter
popd

# Mod zzz-default-settings
pushd package/lean/default-settings/files
sed -i '/http/d' zzz-default-settings
export orig_version="$(cat "zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')"
sed -i "s/${orig_version}/${orig_version} ($(date +"%Y.%m.%d"))/g" zzz-default-settings
popd

#pushd package/lean
#rm -rf autocore
#svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/lean/autocore
#popd

# Add baiduPcsWeb
#https://github.com/immortalwrt/immortalwrt/tree/openwrt-21.02/package/ctcgfw/baidupcs-web
#pushd package/lean
#rm -rf baidupcs-web
#rm -rf luci-app-baidupcs-web
#svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/ctcgfw/baidupcs-web
#svn co https://github.com/immortalwrt/immortalwrt/branches/master/package/ctcgfw/luci-app-baidupcs-web
#popd

# Add po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd


pushd package
rm -rf package/lienol/luci-app-timecontrol
rm -rf package/ntlf9t/{smartdns,luci-app-smartdns}
rm -rf package/ctcgfw/{luci-app-argon-config,luci-theme-argonv3}
rm -rf package/lean/{luci-app-netdata,luci-theme-argon,k3screenctrl}
popd

echo -e " Lean's OpenWrt built on "$(date +%Y.%m.%d)"\n -----------------------------------------------------" >> package/base-files/files/etc/banner
echo "######DIY1.sh end######"
