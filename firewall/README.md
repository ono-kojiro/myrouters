# OPNsense configuration

## Install OPNsense

### login to INSTALLER

```
login: installer
Password: opnsense
```

## Initial Setup

### change LAN address

```
Enter an option: 2     (Set interface IP address)
```

```
Configure IPv4 address LAN interface via DHCP? [y/N] N

Enter the new LAN IPv4 address. Press <ENTER> for none:
> 192.168.122.xxx

Subnet masks are entered as bit counts (like CIDR notation).
e.g. 255.255.255.0 = 24
     255.255.0.0   = 16
     255.0.0.0     = 8

Enter the new LAN IPv4 subnet bit count (1 to 32):
> 24

For a WAN, enter the new LAN IPv4 upstream gateway address.
For a LAN, press <ENTER> for none:
> (none)

Configure IPv6 address LAN interface via DHCP6? [y/N] N

Enter the new LAN IPv6 address. Press <ENTER> for none:
> (none)

Do you want to enable the DHCP server on LAN? [y/N] N

Do you want to change the web GUI protocol form HTTPS to HTTP? [y/N] N
Do you want to generate a new self-signed web GUI certificate? [y/N] N
Restore web GUI access defaults? [y/N] N

...

You can now access the web GUI by opening
the following URL in your web browser:

    https://192.168.122.xxx
```


### enable ssh with console

enable ssh

```
Enter an option: 8    ( Shell)
```

```
# vi /conf/config.xml
...

<opnsense>
  ...
  <system>
     ...
    <ssh>
      <group>admins</group>
      <enabled>enabled</enabled>              <!-- ADD -->
      <port>22</port>                         <!-- ADD -->
      <permitrootlogin>1</permitrootlogin>    <!-- ADD -->
      <passwordauth>1</passwordauth>          <!-- ADD -->
    </ssh>
```

restart sshd

```
# configctl openssh restart
or
# /usr/local/etc/rc.sshd restart
```

### change user shell


```
# vi /conf/config.xml

<opnsense>
  ...
  <system>
    ...
    <user uid="xxx..... ">
      <shell>/bin/sh</shell>   <!-- MODIFY-->
    </user>
    ...

# exit

Enter an option: 11 (Reload all services)

```

### connect with password

```
$ ssh 192.168.122.xxx -l root

root@OPNsense:~ #
```

### add public key

$ cat ~/.ssh/id_ed25519.pub | head -n 1 | base64

copy base64 to "authorizedkeys"

```
# vi /conf/config.xml

<opnsense>
  ...
  <system>
    ...
    <user uid="xxx..... ">
      ...
      <authorizedkeys>(BASE64 of pubkey)</authorizedkeys>
      ...
    </user>

# /usr/local/sbin/opnsense-shell

Enter an option: 11 (Reload all services)
```

After this process, you can log-in via SSH without password.

## Advanced Setup

### create api key and hashed secret

run ./create_api_key.sh

### add api key

```
# vi /conf/config.xml

<opnsense>
  ...
  <system>
    ...
    <user uid="xxx..... ">
      ...
      <apikeys>(key)|(hashed_secret)</apikeys> <!-- ADD -->
      ...
    </user>

# exit

Enter an option: 11 (Reload all services)
```

## disable http preferer check

```
# vi /conf/config.xml

<opnsense>
  ...
  <system>
    ...
    <webgui>
      <nohttpreferercheck>1</nohttpreferercheck>  <!-- ADD --> 
    </webgui>
    ...

# exit

Enter an option: 11 (Reload all services)
```



