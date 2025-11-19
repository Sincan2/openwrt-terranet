module("luci.controller.dmz", package.seeall)

function index()
    entry({"admin", "network", "dmz"}, cbi("dmz"), _("DMZ"), 90)
end
