#!/bin/bash

if [ -e tmp/pids/server.pid ]; then echo 0 > tmp/pids/server.pid; fi

chksql="echo show databases like '$DB_NAME';"
until $chksql|mysql -h mysql-server -u root -p$DB_PASS 
do
        >&2 echo -n "."
        sleep 1
done
>&2 echo "During startup MySQL"

rails db:migrate && \
rails db:seed

#rails s -b 'ssl://0.0.0.0:3000?key=/usr/src/broken_rails_app/config/localhost.key&cert=/usr/src/broken_rails_app/config/localhost.crt'

rails s -b 0.0.0.0
