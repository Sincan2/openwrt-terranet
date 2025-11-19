#!/bin/sh
. /lib/functions.sh

DMZ_CONFIG="terranet_dmz_pro"

# detect WAN
WAN_IF=$(uci -q get network.wan.device)
[ -z "$WAN_IF" ] && WAN_IF=$(uci -q get network.wan.ifname)

cleanup_dmz() {
    nft flush chain inet fw4 prerouting_dmz 2>/dev/null
    nft flush chain inet fw4 forward_dmz 2>/dev/null
}

init_dmz_chains() {
    nft add chain inet fw4 prerouting_dmz 2>/dev/null
    nft add chain inet fw4 forward_dmz 2>/dev/null

    nft insert rule inet fw4 prerouting jump prerouting_dmz
    nft insert rule inet fw4 forward jump forward_dmz
}

apply_rule() {
    config_get WANPORT "$1" wan
    config_get LANIP   "$1" lanip
    config_get LANPORT "$1" lanport
    config_get PROTO   "$1" proto

    [ -z "$WANPORT" ] && return
    [ -z "$LANIP" ] && return
    [ -z "$LANPORT" ] && return

    if [ "$PROTO" = "both" ]; then
        PROTOS="tcp udp"
    else
        PROTOS="$PROTO"
    fi

    for P in $PROTOS; do
        nft add rule inet fw4 prerouting_dmz meta l4proto $P iif "$WAN_IF" dport "$WANPORT" \
            dnat to "$LANIP:$LANPORT" comment \"TerraNetDMZ\"

        nft add rule inet fw4 forward_dmz meta l4proto $P ip daddr "$LANIP" dport "$LANPORT" \
            accept comment \"TerraNetDMZ\"
    done
}

cleanup_dmz
init_dmz_chains
config_load $DMZ_CONFIG
config_foreach apply_rule rule

