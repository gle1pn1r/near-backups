#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=/home/ubuntu/.near/data
BACKUPDIR=/home/ubuntu/.near/backups/near_${DATE}

mkdir $BACKUPDIR

sudo systemctl stop near-main.service

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts

    cp -rf $DATADIR/mainnet/data/ ${BACKUPDIR}/
    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node was started" | ts
