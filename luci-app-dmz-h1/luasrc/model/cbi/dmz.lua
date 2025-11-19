local uci = require "luci.model.uci".cursor()

local m = Map("dmz", translate("DMZ Settings"))

-- MAIN SETTINGS
local s = m:section(NamedSection, "settings", "dmz", translate("DMZ Configuration"))
s.anonymous = true

local enabled = s:option(Flag, "enabled", translate("Enable DMZ"))
enabled.default = 0


-- TABLE OF IP + PORT ENTRIES
local t = m:section(TypedSection, "entry", translate("DMZ IP / Port List"))
t.addremove = true
t.anonymous = true
t.template = "cbi/tblsection"   -- ← TABLE LAYOUT

local ip = t:option(Value, "ip", translate("IP Address"))
ip.datatype = "ip4addr"

local port = t:option(Value, "port", translate("Port(s)"))
port.datatype = "portrange"


-- FIREWALL UPDATE LOGIC
function m.on_commit(map)
    local enabled = uci:get("dmz", "settings", "enabled")

    -- Hapus semua rule DMZ lama
    for sec, data in pairs(uci:get_all("firewall")) do
        if data.name == "DMZ" then
            uci:delete("firewall", sec)
        end
    end

    if enabled == "1" then
        local i = 0

        uci:foreach("dmz", "entry", function(s)
            i = i + 1
            local ip = s.ip
            local port = s.port

            if ip and port then
                uci:section("firewall", "redirect", "dmz_redirect_" .. i, {
                    name = "DMZ",
                    src = "wan",
                    proto = "tcpudp",
                    src_dport = port,
                    dest = "lan",
                    dest_ip = ip,
                    target = "DNAT"
                })
            end
        end)
    end

    uci:commit("firewall")
    os.execute("/etc/init.d/firewall restart")
end

return m
