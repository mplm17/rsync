#!/bin/bash
echo "################################################################"
echo "$(date) - Loading rsync..."
echo "################################################################"
echo "Environment variables:"
echo "CRON_EXPRESSION=${CRON_EXPRESSION}"
RSYNCVARS=( $(compgen -A variable | grep "^RSYNC") )
for RSYNCVAR in RSYNCVARS; do
   echo "${RSYNCVAR}=${!RSYNCVAR}"
   echo "rsync ${!RSYNCVAR}" >> /rsync.sh
done
echo "################################################################"
printenv > /var/spool/cron/crontabs/root
echo "${CRON_EXPRESSION} /rsync.sh >> /rsync.log 2>&1" >> /var/spool/cron/crontabs/root
crontab /var/spool/cron/crontabs/root
exec bash -c "cron && tail -F -n0 /rsync.log"
