#!/bin/sh

top_dir="$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
cd $top_dir

flags=""
  
vmname="Router"

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

start()
{
  virsh start $vmname
}

stop()
{
  virsh shutdown $vmname
}

revert()
{
  echo "INFO: snapshot-info"
  virsh snapshot-info --domain $vmname --current
  snaps=`virsh snapshot-list $vmname | tail -n +3 | awk '{ print $1 }'`
  for snap in $snaps; do
    desc=`virsh snapshot-dumpxml $vmname $snap | xmllint --xpath "string(//description)" -`
    echo "$snap : $desc"
    #sudo virsh snapshot-revert --domain $vmname --snapshotname $snap
    #break
  done
    
  virsh snapshot-revert --domain $vmname --snapshotname $snap
}

hosts

args=""
while [ $# -ne 0 ]; do
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

