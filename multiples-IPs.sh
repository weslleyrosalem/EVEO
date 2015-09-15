#!/bin/bash

# Listar portas que estão ligadas diretamente e estão na rede publica:
for tid in $(awk -F " " '{print $1}' ./allowed_address_pairs)
    do
        mysql neutron -e "select id, mac_address from ports where network_id='"32307540-a5ef-4cf0-9ef7-9760d4f11ffe"' and device_owner='"compute:nova"' and tenant_id='"$tid"';";
    done          


#output
#id	mac_address
#43a4eff1-4519-4c64-bbda-f1e0bccac7bd	fa:16:3e:d5:46:34
#6015f45d-4411-41e2-819c-1456fb088ee1	fa:16:3e:e5:3f:17
#8c92da9c-881c-49b8-902b-03d7526664b8	fa:16:3e:78:e0:ae
#e833a36a-6043-41d9-bab8-7eb29297dea0	fa:16:3e:46:56:5d


#Creando array para segundo comando
#para cada linha de resposta:
#neutron port-update $pid --allowed-address-pairs type=dict list=true mac_address=$mac,ip_address=$ip1
# $pid= port id ; $mac ; $ip1
array=()

# Read the file in parameter and fill the array named "array"
getArray() {
    i=0
    while read line # Read a line
    do
        array[i]=$line # Put it into the array
        i=$(($i + 1))
    done < $1
}

getArray "allowed_address_pairs"

for e in "${array[@]}"
do
    echo "mac_address=$e"
done



