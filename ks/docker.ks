## Options to set on the command line
d-i debian-installer/locale string en_US.UTF-8
d-i console-setup/ask_detect boolean false
d-i console-setup/layout string us

d-i mirror/country string SE
d-i mirror/protocol string http
d-i mirror/http/hostname string archive.ubuntu.com
d-i mirror/http/proxy string
d-i mirror/http/mirror select se.archive.ubuntu.com

d-i netcfg/get_hostname string unassigned-hostname
d-i netcfg/get_domain string unassigned-domain

d-i time/zone string Europe/Stockholm
d-i clock-setup/utc-auto boolean false
d-i clock-setup/utc boolean false

d-i kbd-chooser/method select American English

d-i netcfg/wireless_wep string

d-i base-installer/kernel/override-image string linux-server

d-i debconf debconf/frontend select Noninteractive

d-i pkgsel/install-language-support boolean false
tasksel tasksel/first multiselect standard, ubuntu-server

d-i partman-auto/method string regular

d-i partman/confirm_write_new_label boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true

# Default user
d-i passwd/user-fullname string vagrant
d-i passwd/username string vagrant
d-i passwd/user-password password vagrant
d-i passwd/user-password-again password vagrant
d-i user-setup/encrypt-home boolean false
d-i user-setup/allow-password-weak boolean true

# Minimum packages (see postinstall.sh)
d-i pkgsel/include string wget curl openssh-server ntp xubuntu-desktop

# Upgrade packages after debootstrap? (none, safe-upgrade, full-upgrade)
# (note: set to none for speed)
d-i pkgsel/upgrade select none

d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true
d-i finish-install/reboot_in_progress note

d-i pkgsel/update-policy select none

# debconf-get-selections --install
# Use mirror
#d-i mirror/country string JP
#d-i mirror/protocol string http
#d-i mirror/http/hostname string jp.archive.ubuntu.com
#d-i mirror/http/proxy string

d-i preseed/late_command string chroot /target sh -c "/usr/bin/wget -O /tmp/postinstall http://192.168.2.13:8080/ks/docker-postinstall.sh && /bin/sh -x /tmp/postinstall"
