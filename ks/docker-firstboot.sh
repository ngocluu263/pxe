#!/bin/sh

for i in $(/usr/bin/curl -s -L https://raw.github.com/pandrew/kickstart/master/users.txt | cat);do
	useradd -b /home -m -k /etc/skel -s /bin/bash $i
	#pass=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c8)
 	#echo "$i:$pass" >> /root/accounts.txt
	#echo "$i:$pass" | chpasswd
	echo "$i:$i" | chpasswd
	#-M 90 maximum number of days between password change
	#-W 60 set expiration warning days to N before password change is req.
	#-I 7 if user has not logged in N days before account is locked
	chage -M 90 -W 7 -I 7 -d 0 $i	
done

# Add the Docker repository key to your local keychain
# using apt-key finger you can check the fingerprint matches 36A1 D786 9245 C895 0F96 6E92 D857 6A8B A88D 21E9
/usr/bin/curl http://get.docker.io/gpg | apt-key add -

# Add the Docker repository to your apt sources list.
echo "deb https://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list

# update
/usr/bin/apt-get update

# install
/usr/bin/apt-get -y install lxc-docker

update-rc.d -f firstboot remove

## Reboot into the new kernel
/sbin/reboot
