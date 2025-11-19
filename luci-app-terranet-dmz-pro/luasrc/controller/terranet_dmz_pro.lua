module("luci.controller.terranet_dmz_pro", package.seeall)

function index()
    entry({"admin", "network", "terranet_dmz_pro"},
        cbi("terranet_dmz_pro"), "TerraNet DMZ PRO v5", 30).dependent = true
end
