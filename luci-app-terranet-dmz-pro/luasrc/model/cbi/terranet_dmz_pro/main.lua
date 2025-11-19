local sys  = require "luci.sys"
local uci  = require "luci.model.uci".cursor()

m = Map("terranet_dmz_pro", "TerraNet DMZ PRO v5",
    "DMZ Forwarding using nftables-native.")

s = m:section(TypedSection, "rule", "DMZ Rules")
s.addremove = true
s.anonymous = true

wanp = s:option(Value, "wan", "WAN Port / Range")
proto = s:option(ListValue, "proto", "Protocol")
proto:value("tcp")
proto:value("udp")
proto:value("both")

lanip = s:option(Value, "lanip", "LAN IP Target")
lanport = s:option(Value, "lanport", "LAN Port / Range")

function m.on_commit(self)
    luci.sys.call("/usr/lib/terranet_dmz_pro.sh >/dev/null 2>&1")
end

---------------------------------------------------------
-- STATUS SECTION (TARUH DI SINI!)
---------------------------------------------------------

local status = m:section(SimpleSection)
status.title = "Active nftables DMZ Rules"

function status.cfgvalue()
    local p = sys.exec("nft -a list chain inet fw4 prerouting_dmz 2>/dev/null | grep TerraNetDMZ")
    local f = sys.exec("nft -a list chain inet fw4 forward_dmz 2>/dev/null | grep TerraNetDMZ")

    local data = p .. f
    if data == "" then
        return "No active DMZ rules."
    end

    return "<pre>" .. data .. "</pre>"
end

---------------------------------------------------------

return m
