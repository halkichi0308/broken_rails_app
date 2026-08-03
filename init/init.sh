#!/bin/bash

if [ -e tmp/pids/server.pid ]; then echo 0 > tmp/pids/server.pid; fi

if command -v mysql >/dev/null 2>&1; then
        chksql="echo show databases like '$DB_NAME';"
        until $chksql|mysql -h mysql-server -u root -p$DB_PASS 
        do
                >&2 echo -n "."
                sleep 1
        done
        >&2 echo "During startup MySQL"
else
        >&2 echo "mysql command not found: falling back to SQLite"
        export DATABASE_URL="sqlite3:db/development.sqlite3"
fi

rails db:migrate && \
rails db:seed

#rails s -b 'ssl://0.0.0.0:3000?key=/usr/src/broken_rails_app/config/localhost.key&cert=/usr/src/broken_rails_app/config/localhost.crt'

rails s -b 0.0.0.0
