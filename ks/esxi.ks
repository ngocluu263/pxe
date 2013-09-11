# Sample kickstart for ESXi 5.1
# William Lam
# www.virtuallyghetto.com
#########################################
 
accepteula
install --firstdisk --overwritevmfs
rootpw vmware123
reboot
include /tmp/networkconfig
 
%pre --interpreter=busybox
 
# extract network info from bootup
VMK_INT="vmk0"
VMK_LINE=$(localcli network ip interface ipv4 get | grep "${VMK_INT}")
#IPADDR=192.168.2.20
IPADDR=$(echo "${VMK_LINE}" | awk '{print $2}')
NETMASK=$(echo "${VMK_LINE}" | awk '{print $3}')
GATEWAY=$(localcli network ip route ipv4 list | grep default | awk '{print $3}')
DNS="172.30.0.100,172.30.0.200"
#HOSTNAME=$(nslookup "${IPADDR}" | grep Address | awk '{print $4}' | tail -1)
HOSTNAME=test 
echo "network --bootproto=static --addvmportgroup=false --device=vmnic0 --ip=${IPADDR} --netmask=${NETMASK} --gateway=${GATEWAY} --nameserver=${DNS} --hostname=${HOSTNAME}" > /tmp/networkconfig
 
%firstboot --interpreter=busybox
