#!/bin/sh

#usage update_hosts /etc/hosts
processfile="${1-/etc/hosts}"
tmpfile=${processFile}.tmp
for service in $(docker ps -q) ; do
  domain="";
  for vh in $(docker inspect --format '{{ .Config.Env }}' ${service} | egrep -oh 'VIRTUAL_HOST=(\w|\.)+' | tr "=" "\n") ; do
    if [ $vh != 'VIRTUAL_HOST' ]; then
      domain="${vh}"
    fi
  done
  if [ -n "${domain}" ]; then
    ipaddress=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${service})
    grep -v $domain $processfile > $tmpfile
    echo $ipaddress '\t' $domain >> $tmpfile
    echo '127.0.0.1 \t' $domain >> $tmpfile
    mv $tmpfile $processfile
  fi
done

cat $processfile
