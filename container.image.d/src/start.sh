#!/usr/bin/env bash

set -x
echo XPLA_HOME=${XPLA_HOME}

xplad start --home=${XPLA_HOME} --log_level=info

#          1 ~    755,000 - 1.0.0 
#    755,000 ~  2,459,600 - 1.1.0 
#  2,459,600 ~  6,881,850 - 1.2.0 

# time tar -c -I 'lz4' -f /arch/lib/xplad/xpla__archive__dimension_37-1__data__0000755000.tar.lz4 -C /data/lib/xplad/dimension_37-1/data .
# time tar -c -I 'lz4' -f /arch/lib/xplad/xpla__archive__dimension_37-1__data__0002459599.tar.lz4 -C /data/lib/xplad/dimension_37-1/data .
# time tar -c -I 'lz4' -f /arch/lib/xplad/xpla__archive__dimension_37-1__data__0006881850.tar.lz4 -C /data/lib/xplad/dimension_37-1/data .

# mkdir -p /data/lib/xplad/dimension_37-1/data && time tar -x -I 'lz4' -f /arch/lib/xplad/xpla__archive__dimension_37-1__data__0000755000.tar.lz4 -C /data/lib/xplad/dimension_37-1/data

