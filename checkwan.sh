#!/bin/bash
# Our external ip
externip=192.168.1.1
# We check if the wan ip has changed
checkip=`/usr/bin/curl -s http://whatismijnip.nl |cut -d " " -f 5`
#We comprare the two and email the new ip
if [ "$checkip" != "$externip" ] ; then
    /bin/sed -r -i 's/externip=(\b[0-9]{1,3}\.){3}[0-9]{1,3}\b'/externip=$checkip/ /root/checkwan/checkwan.sh
    /bin/mail -s "Host has a new wan ip" my@email.com <<< "The WAN IP has changed. The old address was $externip, the new is $checkip."
    logdate=`/bin/date +"%d-%m-%Y %H:%M:%S"`
    /bin/echo $logdate - The WAN IP has changed! >>  /root/checkwan/checkwan.log
else
    logdate=`date +"%d-%m-%Y %H:%M:%S"`
    /bin/echo $logdate - The WAN IP has not changed! >>  /root/checkwan/checkwan.log
fi
