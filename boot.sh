#!/bin/bash
APP_NAME=/home/ferris/anaconda3/envs/default/bin/jupyter-lab

usage() {
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
}

exist() {
    ps -ef | grep $APP_NAME | grep -v grep | awk '{print $2}'
}

start() {
    pid=$(exist)
    if [ -n "$pid" ]; then
        echo "$APP_NAME is already running. pid=$pid"
    else
        echo "Starting $APP_NAME ..."
        nohup $APP_NAME --no-browser --ip=0.0.0.0 --port=8888 --ServerApp.run_in_background=False > /dev/null 2>&1 &
    fi
}

stop() {
    pid=$(exist)
    if [ -n "$pid" ]; then
        echo "Stopping $APP_NAME (pid=$pid)"
        kill $pid || kill -9 $pid
    else
        echo "$APP_NAME is not running"
    fi
}

status() {
    pid=$(exist)
    if [ -n "$pid" ]; then
        echo "$APP_NAME is running. pid=$pid"
    else
        echo "$APP_NAME is NOT running."
    fi
}

restart() {
    stop
    sleep 2
    start
}

case "$1" in
"start")
    start
    ;;
"stop")
    stop
    ;;
"status")
    status
    ;;
"restart")
    restart
    ;;
*)
    usage
    ;;
esac