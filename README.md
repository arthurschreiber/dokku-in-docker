
```bash
sudo docker run --rm -it -p 8080:80 -p 2222:22 -v /opt/mount/dokku:/home/dokku \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /etc/ssh/ssh_host_dsa_key:/etc/ssh/ssh_host_dsa_key \
  -v /etc/ssh/ssh_host_dsa_key.pub:/etc/ssh/ssh_host_dsa_key.pub \
  -v /etc/ssh/ssh_host_key:/etc/ssh/ssh_host_key \
  -v /etc/ssh/ssh_host_key.pub:/etc/ssh/ssh_host_key.pub \
  -v /etc/ssh/ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key \
  -v /etc/ssh/ssh_host_rsa_key.pub:/etc/ssh/ssh_host_rsa_key.pub \
  arthurschreiber/dokku-in-docker
```
