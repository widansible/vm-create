# System language
lang en_US
# Language modules to install
langsupport en_US
# System keyboard
keyboard us
# System mouse
mouse
# System timezone
timezone --utc Asia/Jakarta
# Root password
# Root password
rootpw --iscrypted --password $1$Dag6ag1J$idEhFtLsac/TZGfW1Ko95/
# Initial user
user widysible --fullname "widya" --iscrypted --password $1$Dag6ag1J$idEhFtLsac/TZGfW1Ko95/
# Reboot after installation
reboot
# Use text mode install
text
# Install OS instead of upgrade
install
# Use CDROM installation media
cdrom
# System bootloader configuration
bootloader --location=mbr 
# Clear the Master Boot Record
zerombr yes
# Partition clearing information
clearpart --all 
# Disk partitioning information
part / --fstype ext4 --size 3700 --grow
part swap --size 200 
# System authorization infomation
auth  --useshadow  --enablemd5 
# Firewall configuration
firewall --enabled --ssh 
# Do not configure the X Window System
skipx
%post --interpreter=/bin/bash
echo ### Redirect output to console
exec < /dev/tty6 > /dev/tty6
chvt 6

echo ### Add public ssh key for Ansible
mkdir -m0700 -p /home/widysible/.ssh
cat <<EOF >/home/widysible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBqAMPfPPdMuYmwxJpoBrEeWwSmB3KU2WmaCNJrRIKVz8rzD2XADaV1JsO/peBke20W4behyeUAT+7U9SLJZlCotiXHTGu2klSQQicRjwmZfKuO0+S8Ka7AnWn8uhTwsv2QJeFStEN8NPPRXtKu7HX/+hznM//WjaX8luyByPzuka5kLCIS2RQO1NVvKHR41lD2DspeCcJ6yw1YIMDdbNcH8M4zSTf1B/MgOMUk4kXaOnFgrST9xfhNfDy0JRykOCJ2A9Ap3x7jA+uMkTfOUzXWVJsKuqv5mha7ScbxSexvMcxbUAMOhKEr9ppe2+n7oRmw50c1JQ8qMtI0S3uFz6qWb0wKDDa7B+fA4ThjNZiPeYoOAy7BwD4AtipiHJBpU78XnqJbg0o1CDsS6Q4KAkGy6zb+nv1BRM9InAC9MjqEeCywrLf4/iMjnUCULfECCIhRuWFFbJJgq4plsv1ZRjx43DZ1WukMPPeyuglX/zvSRzAWXLzPqL9KQyIk77g75dSAShQbULguhhNN644mQVcXsTs9o0ub5ErgfkMqKSPd2nFQRsrK6qziPAIdUfj81IzQQ7BDmuyQyvUXUf34QfoB/ZVW/EqPW5dx6VXXflDuE3Vs496XFRQ89H6lRcqM49dTAhhKWgRNqquMOgiMvDU0zwJmLpC5xS+acutKtYC8Q== root@paa
EOF
chown -R widysible:widysible /home/widysible
chown -R widysible:widysible /home/widysible/.ssh
chmod 0600 /home/widysible/.ssh/authorized_keys
mkdir -m0700 -p /root/.ssh
cat <<EOF >/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBqAMPfPPdMuYmwxJpoBrEeWwSmB3KU2WmaCNJrRIKVz8rzD2XADaV1JsO/peBke20W4behyeUAT+7U9SLJZlCotiXHTGu2klSQQicRjwmZfKuO0+S8Ka7AnWn8uhTwsv2QJeFStEN8NPPRXtKu7HX/+hznM//WjaX8luyByPzuka5kLCIS2RQO1NVvKHR41lD2DspeCcJ6yw1YIMDdbNcH8M4zSTf1B/MgOMUk4kXaOnFgrST9xfhNfDy0JRykOCJ2A9Ap3x7jA+uMkTfOUzXWVJsKuqv5mha7ScbxSexvMcxbUAMOhKEr9ppe2+n7oRmw50c1JQ8qMtI0S3uFz6qWb0wKDDa7B+fA4ThjNZiPeYoOAy7BwD4AtipiHJBpU78XnqJbg0o1CDsS6Q4KAkGy6zb+nv1BRM9InAC9MjqEeCywrLf4/iMjnUCULfECCIhRuWFFbJJgq4plsv1ZRjx43DZ1WukMPPeyuglX/zvSRzAWXLzPqL9KQyIk77g75dSAShQbULguhhNN644mQVcXsTs9o0ub5ErgfkMqKSPd2nFQRsrK6qziPAIdUfj81IzQQ7BDmuyQyvUXUf34QfoB/ZVW/EqPW5dx6VXXflDuE3Vs496XFRQ89H6lRcqM49dTAhhKWgRNqquMOgiMvDU0zwJmLpC5xS+acutKtYC8Q== root@paa
EOF
chmod 0600 /root/.ssh/authorized_keys
# Allow Ansible to sudo w/o a password
echo "widysible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/widysible

echo ### Update all packages
#apt-get update
#apt-get -y upgrade
# Install packages
apt-get install -y openssh-server vim python
echo ### Enable serial console so virsh can connect to the console
systemctl enable serial-getty@ttyS0.service
systemctl start serial-getty@ttyS0.service
echo ### Change back to terminal 1
chvt 1
