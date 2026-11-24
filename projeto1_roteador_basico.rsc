# 2026-11-23 11:09:23 by RouterOS 7.25.1
# software id = M2JQ-K8YY
#
# model = RB450
# serial number = 36E00436A087
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip dhcp-server network
add address=192.168.88.0/24 dns-server=8.8.8.8,1.1.1.1 gateway=192.168.88.1
/ip pool
add name=dhcp_pool1 ranges=192.168.88.2-192.168.88.254
/interface bridge
add name="BRIDGE - LAN"
/ip address
add address=192.168.88.1/24 interface="BRIDGE - LAN" network=192.168.88.0
/ip dhcp-client
add interface=ether1 name=WAN
/ip dhcp-server
add address-pool=dhcp_pool1 interface="BRIDGE - LAN" name=dhcp1
/ip dns
set allow-remote-requests=yes
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/system clock
set time-zone-name=America/Sao_Paulo
/interface bridge port
add bridge="BRIDGE - LAN" interface=ether2
add bridge="BRIDGE - LAN" interface=ether3
add bridge="BRIDGE - LAN" interface=ether4
add bridge="BRIDGE - LAN" interface=ether5
