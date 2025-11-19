local sys = require "luci.sys"

m = Map("terranet_dmz_pro", "TerraNet DMZ PRO v5",
    "DMZ Forwarding using nftables-native.")

function m.on_commit(self)
    luci.sys.call("/usr/lib/terranet_dmz_pro.sh >/dev/null 2>&1")
end

s = m:section(TypedSection, "rule", "DMZ Rules")
s.addremove = true
s.anonymous = true

wan = s:option(Value, "wan", "WAN Port / Range")
wan.placeholder = "20201 / 20000-21000"

proto = s:option(ListValue, "proto", "Protocol")
proto:value("tcp")
proto:value("udp")
proto:value("both")

lanip = s:option(Value, "lanip", "LAN IP Target")
lanip.placeholder = "192.168.0.143"

lanport = s:option(Value, "lanport", "LAN Port / Range")
lanport.placeholder = "20201 / 20000-21000"

-- STATUS NFT
st = m:section(TypedSection, "status", "Active nftables DMZ Rules")
st.anonymous = true
function st.cfgvalue()
    local data = sys.exec("nft list ruleset | grep TerraNetDMZ -n")
    if data == "" then return "No active DMZ rules." end
    return "<pre>" .. data .. "</pre>"
end

return m
