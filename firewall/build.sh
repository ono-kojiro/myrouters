#!/bin/sh

top_dir="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd $top_dir

flags=""

help()
{
  usage
}

usage()
{
  cat << EOS
usage : $0 [options] target1 target2 ...

target:
  deploy
EOS

}

all()
{
  deploy
}

hosts()
{
  ansible-inventory -i inventory.yml --list --yaml > hosts.yml
}

deploy()
{
   ansible-playbook $flags -i hosts.yml site.yml
}

default()
{
  tag=$1
  ansible-playbook $flags -i hosts.yml -t $tag site.yml
}

apikey()
{
  ansible-playbook $flags -i hosts.yml -t apikey site.yml
}

fetch()
{
  ssh firewall -l root \
    tar -C /usr/local/opnsense/mvc/app/controllers \
      -cJvf /tmp/OPNsense.tar.xz OPNsense
  scp root@firewall:/tmp/OPNsense.tar.xz .
  ssh firewall -l root rm -f /tmp/OPNsense.tar.xz
}

extract()
{
  mkdir -p work
  tar -C work/ -xJvf ${top_dir}/OPNsense.tar.xz
}

test()
{
  #. ./apikey.shrc
  . ./key_and_secret.shrc

  url=https://192.168.122.99/api/core/system/status
  curl -s -u "$key:$secret" -k $url | jq .
}

hosts

args=""
while [ "$#" -ne 0 ]; do
  case $1 in
    -h )
      usage
      exit 1
      ;;
    -v )
      verbose=1
      ;;
	-* )
	  flags="$flags $1"
	  ;;
    * )
      args="$args $1"
      ;;
  esac
  
  shift
done

if [ -z "$args" ]; then
  help
  exit 1
fi

for arg in $args; do
  num=`LANG=C type $arg | grep 'function' | wc -l`
  if [ $num -ne 0 ]; then
    $arg
  else
    #echo "ERROR : $arg is not shell function"
    #exit 1
    default $arg
  fi
done

