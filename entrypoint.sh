#!/bin/bash
echo "################################################################"
echo "$(date) - Loading rsync..."
echo "################################################################"
echo "Environment variables:"
echo "CRON_EXPRESSION=${CRON_EXPRESSION}"
echo '#!/bin/bash' > rsync.sh
echo 'echo "$(date) - rsync.sh started..."' >> rsync.sh
RSYNCVARS=$(compgen -A variable | grep "^RSYNC")
for RSYNCVAR in $RSYNCVARS; do
   echo "${RSYNCVAR}=${!RSYNCVAR}"
   echo 'echo "$(date) - Start '${RSYNCVAR}' with command: rsync '${!RSYNCVAR}'"' >> /rsync.sh
   echo "rsync ${!RSYNCVAR}" >> /rsync.sh
   echo 'echo "$(date) - '${RSYNCVAR}' has ended."' >> /rsync.sh
done
echo 'echo "$(date) - rsync.sh finished..."' >> rsync.sh
echo "################################################################"
printenv > /var/spool/cron/crontabs/root
echo "${CRON_EXPRESSION} /rsync.sh >> /rsync.log 2>&1" >> /var/spool/cron/crontabs/root
crontab /var/spool/cron/crontabs/root
exec bash -c "cron && tail -F -n0 /rsync.log"
