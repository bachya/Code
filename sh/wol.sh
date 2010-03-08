#!/bin/sh

STATION=""
WOL=/usr/sbin/wol
LEASES=/tmp/dnsmasq.leases
DEV=br0

if [ "$#" -ne 1 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  echo "Usage: wol [host]" >&2
  return 1
fi

COMMAND="IP="

ssh root@192.168.1.1 $COMMAND
