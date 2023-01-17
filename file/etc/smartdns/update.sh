#!/bin/bash

rm -f /etc/smartdns/china.list
rm -f /etc/smartdns/direct.conf
rm -f /etc/smartdns/overseas.list

mkdir -p /tmp/smartdns/china
curl -sS https://ghproxy.com/https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf -o /tmp/smartdns/china/accelerated-domains.china.conf
curl -sS https://ghproxy.com/https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/apple.china.conf -o /tmp/smartdns/china/apple.china.conf
curl -sS https://ghproxy.com/https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/google.china.conf -o /tmp/smartdns/china/google.china.conf
cat /tmp/smartdns/china/*.conf > /tmp/smartdns/china/china.txt
sed -e 's|^server=/\(.*\)/114.114.114.114$|\1|' /tmp/smartdns/china/china.txt | grep -Ev '^#' | sort > /etc/smartdns/china.list

mkdir -p /tmp/smartdns/direct
curl -sS https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/direct-list.txt -o /tmp/smartdns/direct/direct-list.txt
curl -sS https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/apple-cn.txt -o /tmp/smartdns/direct/apple-cn.txt
curl -sS https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/google-cn.txt -o /tmp/smartdns/direct/google-cn.txt
cat /tmp/smartdns/direct/*.txt | sort > /etc/smartdns/direct.list

mkdir -p /tmp/smartdns/overseas
curl -sS https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/proxy-list.txt -o /tmp/smartdns/overseas/direct-list.txt
curl -sS https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/gfw.txt -o /tmp/smartdns/overseas/gfw.txt
curl -sS https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/greatfire.txt -o /tmp/smartdns/overseas/greatfire.txt
cat /tmp/smartdns/overseas/*.txt | sort > /etc/smartdns/overseas.list

/etc/init.d/smartdns restart

rm -rf /tmp/smartdns