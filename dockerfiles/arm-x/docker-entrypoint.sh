#!/bin/bash

echo ARM-X is being extracted into your named docker volume.
echo This is necessary because NFS is magic.
sleep 2
sudo tar xvf /armx.tar -C /
echo

echo Starting the tunnel interface
sudo /etc/local.d/10-tun-network.start 2>&1 >/dev/null

echo Initializing the NFS
sudo rpcbind -w
sudo rpcinfo
sudo rpc.nfsd --debug 8
sudo rpc.nfsd --debug 8
sudo exportfs -rv
sudo exportfs
sudo rpc.mountd --debug all

echo
echo Container is ready
echo
exec "$@"
