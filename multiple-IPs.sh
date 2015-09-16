#!/bin/bash
export OS_USERNAME=admin
export OS_TENANT_NAME=admin
export OS_PASSWORD=e611874419c2c5f2b85ba12106d343bd
export OS_AUTH_URL=http://177.93.110.13:35357/v2.0/
export PS1='[\u@\h \W(openstack_admin)]\$ '

for line in `cat ./allowed_address_pairs2`; do
        IFS='=' read -a tenant <<< "$line"
        IFS=':' read -a ip <<< "${tenant[1]}"
        while read -a line
        do
                pairs=""
                for ipa in "${ip[@]}"
                do
                        pairs+=" mac_address=${line[1]},ip_address=$ipa"
                done
            neutron port-update ${line[0]} --allowed-address-pairs type=dict list=true $pairs
        done < <(mysql neutron -Ne "select id, mac_address from ports where network_id='"32307540-a5ef-4cf0-9ef7-9760d4f11ffe"' and device_owner='"compute:nova"' and tenant_id='"${tenant[0]}"';")
done
