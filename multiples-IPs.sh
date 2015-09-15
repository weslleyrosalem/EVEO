#!/bin/bash


customers=$(awk -F " " '{print $1}' ./allowed_address_pairs)

for tid in $customers; do
        query1=$(mysql neutron -e "select id from ports where network_id='"32307540-a5ef-4cf0-9ef7-9760d4f11ffe"' and device_owner='"compute:nova"' and tenant_id='"$tid"';")
        query2=$(mysql neutron -e "select mac_address from ports where network_id='"32307540-a5ef-4cf0-9ef7-9760d4f11ffe"' and device_owner='"compute:nova"' and tenant_id='"$tid"';")
    
        for pid in $query1 && mac in $query2; do
                echo "neutron port-update $pid --allowed-address-pairs type=dict list=true mac_address=$mac,ip_address=ip1"
        done        
done
