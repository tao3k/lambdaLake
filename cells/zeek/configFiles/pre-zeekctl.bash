if [[ ! -d "/var/lib/zeek" ]];then
    mkdir -p /var/lib/zeek/policy \
        /var/lib/zeek/spool \
        /var/lib/zeek/logs \
        /var/lib/zeek/scripts\
        /var/lib/zeek/etc
    # shellcheck disable=all
    cp -r "$("$@"/zeek-config --zeek_dist)"/share/zeekctl/scripts/* /var/lib/zeek/scripts/
fi

cat <<EOF > /var/lib/zeek/etc/node.cfg
[zeek]
type=standalone
host=localhost
interface=eno1
EOF

cat <<EOF > /var/lib/zeek/etc/networks.cfg
# List of local networks in CIDR notation, optionally followed by a
# descriptive tag.
# For example, "10.0.0.0/8" or "fe80::/64" are valid prefixes.

10.0.0.0/8          Private IP space
172.16.0.0/12       Private IP space
192.168.0.0/16      Private IP space
EOF
