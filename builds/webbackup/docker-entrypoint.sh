#!/bin/bash
set -e

echo >&2 'Starting webbackup build.'
cd /app/webbackup
echo >&2 'Cloning repositories.'
pwd
git clone https://github.com/sturple/webbackup.git
git clone https://github.com/sturple/pycloud.git
echo>&2 'Setting permisions.'
chmod +x /app/webbackup/webbackup/webbackup.py
pip3 install -e pycloud 1>/dev/null
cd /app/webbackup/webbackup
python3 webbackup.py --config /app/config/web_backups.cfg
echo >&2 'Finsihed'
exec "$@"
