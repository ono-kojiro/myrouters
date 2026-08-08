# OPNsense configuration

## Install OPNsense

### login to INSTALLER

```
login: installer
Password: opnsense
```

## Initial Setup

### enable ssh with console

enable ssh

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



