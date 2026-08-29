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

generate_apikey()
{
  mkdir -p group_vars

  if [ ! -e apikey.shrc ]; then
    key=`openssl rand -base64 48`
    echo "key is $key" 
    
    secret=`openssl rand -hex 32`
 
    echo "secret is $secret"
    hash=`openssl passwd -6 "$secret"`

    echo "hash is $hash"

    {
      echo "key=$key"
      echo "secret=$secret"
    } | tee apikey.shrc

    {
      echo "---"
      echo "key: $key"
      echo "hash: $hash"
    } | tee vars/apikey.yml
  fi
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

