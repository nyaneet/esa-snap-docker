#!/bin/bash

/usr/local/snap/bin/snappy-conf /usr/bin/python3 | \
while read -r line; do
    echo "$line"
    if [ "$line" = "or copy the 'snappy' module into your Python's 'site-packages' directory." ]
    then
        sleep 5
        echo "Setup is done. Terminating..."
        kill -9 $(pgrep -f jre)
    fi
done

cd /root/.snap/snap-python/snappy && python3 setup.py install
