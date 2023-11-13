FROM DROPLET
nano /etc/ssh/sshd_config.d/50-cloud-init.conf
no -> yes
systemctl restart sshd

FROM YOUR MACHINE 
ssh-copy-id user@ip

FROM DROPLET
nano /etc/ssh/sshd_config.d/50-cloud-init.conf
no -> yes
systemctl restart sshd 
