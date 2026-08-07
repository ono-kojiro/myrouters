# setup Router

## configure on Console

### permit root login

```
# vi /etc/ssh/sshd_config
...
PermitRootLogin yes
...

# service sshd restart

```

### confirm DHCP address

```
# ifconfig vtnet0
```

## access using ssh

```
$ ssh 192.168.122.xxx -l root
(enter password here)
#
```

## ssh public key authentication

```
# mkdir -p ~/.ssh/

# echo "ssh-ed25519 xxxxxxxx...." > ~/.ssh/authorized_keys

# exit

$ ssh 192.168.122.xxx -l root
(no password here)

#
```

### disable password authentication

```
# vi /etc/ssh/sshd_config
...
PasswordAuthentication no
...

# service sshd restart

```

## configure network

```
# vi /etc/rc.conf
...
ifconfig_vtnet0="inet 192.168.122.xx/24"
defaultrouter="192.168.122.1"

# nohup service netif restart &

```

## http proxy configuration

TBD

## freebsd-update

```
# freebsd-update fetch

# freebsd-update install
```

## install python3 for ansible

```
# sed -i -e 's|pkg+https|https|' /etc/pkg/FreeBSD.conf

# pkg update

# pkg install python3
```

## change default NIC configuration

```
  - name: vtnet0
    type:   Bridge to LAN
    source: virbr0
    model:  virtio
    mac: (change) ex. 52:54:00:a6:e3:55 -> 52:54:00:a6:e3:00
```

## add 3 NICs

```
  - name: vtnet1
    type: Bridge to LAN
    source: br10
    model: virtio
    mac: 52:54:00:a6:e3:10
  
  - name: vtnet2
    type: Bridge to LAN
    source: br20
    model: virtio
    mac: 52:54:00:a6:e3:20
    
  - name: vtnet3
    type: Bridge to LAN
    source: br30
    model: virtio
    mac: 52:54:00:a6:e3:30
```

## boot VM

```
$ virsh start Router
```

## login

login from console

## change vtne0 configuration

```
# vi /etc/rc.conf
...
ifconfig_vtnet0="inet 192.168.122.199/24"
defaultrouter="192.168.122.1"

(comment out following line)
#ifconfig_vtnet0_ipv6="inet6 accept_rtadv"

# service netif restart
# service routing restart
```

## access using ssh

```
$ ssh 192.168.122.99
```

## install python3

```
# pkg update
# pkg install python314
```

## run ansible playbooks

```
$ sh build.sh deploy
``` 
