1. change default NIC configuration

  - NIC0
    type:   Bridge to LAN
    source: br10
    model:  virtio
    mac: (change) ex 52:54:00:40:44:XX -> 52:54:00:40:44:10

2. add 3 NICs

  - NIC1
    type: Bridge to LAN
    source: br11
    model: virtio
    mac: 52:54:00:40:44:11
  
  - NIC2
    type: Bridge to LAN
    source: br12
    model: virtio
    mac: 52:54:00:40:44:12
    
  - NIC3
    type: Bridge to LAN
    source: br13
    model: virtio
    mac: 52:54:00:40:44:13
    
3. boot VM

4. login

5. change vtne0 configuration

   # vi /etc/rc.conf
   ...
   ifconfig_vtnet0="inet 172.16.10.99/24"
   defaultrouter="172.16.10.1"
   
   (comment out following line)
   #ifconfig_vtnet0_ipv6="inet6 accept_rtadv"

   # service netif restart
   # service routing restart


6. ssh 172.16.10.99 using ProxyJump

7. install python3

   # pkg update
   # pkg install pyhon314

7. run ansible playbooks
 
