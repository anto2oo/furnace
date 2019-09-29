#! /bin/sh
#
# chkconfig: - 84 16
# description:  PHP FastCGI Process Manager for pool '${username}'
# processname: php-fpm-${username}
# config: /etc/php-fpm.d/${username}.conf
# pidfile: /var/run/php-fpm/${username}.pid

# Standard LSB functions
#. /lib/lsb/init-functions

# Source function library.
. /etc/init.d/functions

# Check that networking is up.
. /etc/sysconfig/network

if [ "$NETWORKING" = "no" ]
then
    exit 0
fi

RETVAL=0
prog="php-fpm-${username}"
pidfile=/var/run/php-fpm/${username}.pid
lockfile=/var/lock/subsys/php-fpm-${username}
fpmconfig=/etc/php-fpm.d/${username}.conf

start () {
    echo -n $"Starting $prog: "
    daemon --pidfile ${pidfile} php-fpm --fpm-config=${fpmconfig} --daemonize
    RETVAL=$?
    echo
    [ $RETVAL -eq 0 ] && touch ${lockfile}
}
stop () {
    echo -n $"Stopping $prog: "
    killproc -p ${pidfile} php-fpm
    RETVAL=$?
    echo
    if [ $RETVAL -eq 0 ] ; then
        rm -f ${lockfile} ${pidfile}
    fi
}

restart () {
        stop
        start
}

reload () {
    echo -n $"Reloading $prog: "
    killproc -p ${pidfile} php-fpm -USR2
    RETVAL=$?
    echo
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status -p ${pidfile} php-fpm
    RETVAL=$?
    ;;
  restart)
    restart
    ;;
  reload|force-reload)
    reload
    ;;
  condrestart|try-restart)
    [ -f ${lockfile} ] && restart || :
    ;;
  *)
    echo $"Usage: $0 {start|stop|status|restart|reload|force-reload|condrestart|try-restart}"
    RETVAL=2
        ;;
esac

exit $RETVAL