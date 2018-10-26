#
# SCRIPT CRIA INDEX PARA INVENTARIO AUTOMATICO BANORTE SOLARIS
# DESENVOLVIDO POR JACQUES JACOB - UNIX IBM MEXICO
# DATA 14/02/2018
# VERSION 1.0
#

INDEXFILE=/var/www/html/index.html
INDEX_BKP=/var/www/html/backup.html

echo "<html>" > $INDEXFILE

echo "<head>" >> $INDEXFILE
echo "<title>Inventory Banorte - Solaris Environment</title>" >> $INDEXFILE 
echo "<center><img src="banorte.JPG"></center>" >> $INDEXFILE
echo "</head>" >> $INDEXFILE
echo "<p>" >> $INDEXFILE
echo "<center><h2>Solaris Banorte Inventory - Oracle SPARC M5-32</h2></center>" >> $INDEXFILE
echo "<p>" >> $INDEXFILE
echo "<center><a href="index.html"><img src="solaris.jpg"></a>.:.<a target="_blank" href="inventory/linux/index.html"><img src="linux.jpg"></a></center>" >> $INDEXFILE
echo "<p>" >> $INDEXFILE

echo "<center><table border=1>" >> $INDEXFILE
  echo "<tr>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Type</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Hostname</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">IP Data</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">IP Backup</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Operational System</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Kernel/Release</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Uptime</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Application</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Inventory File</th>" >> $INDEXFILE
    echo "<th bgcolor="#ffcccc">Inventory Date</th>" >> $INDEXFILE
  echo "</tr>" >> $INDEXFILE


for a in `cat /var/www/html/list/m5*.conf`; do
for i in `ls /var/www/html/inventory/*.html | grep -w "$a"_cfg.html`; do

HTML=`echo $i | gawk -F/ '{ print $6 }'`
IP=`cat $i | egrep "inet " | egrep -v "127.|0.0.0|10.30|169." | awk '{ print $2 }' | head -1`
IPBKP=`cat $i | egrep "inet " | grep "10.30" | awk '{ print $2 }' | head -1`
DATE=`cat $i | grep Created | awk '{ print $3,$4 }' | head -1`
HOSTNAME=`echo $HTML | gawk -F_ '{ print $1 }'`
UPTIME=`cat $i | egrep "load average:" | awk '{ print $3,$4,$5,$6 }' | cut -d, -f 1,2`
SO=`cat $i | grep "PRE>SunOS" | awk '{ print $1,$3 }' | cut -d'>' -f 2`
RELEASE=`cat $i | grep "PRE>SunOS" | awk '{ print $4 }' | cut -d'_' -f 2`
TYPE=`echo $i | grep "m5[12][sp][0123]"`
ZONE=`cat /var/www/html/list/zones.conf | grep -w $HOSTNAME`
APP=`grep -w $HOSTNAME /var/www/html/list/env.conf | awk -F: '{ print $2 }'`

echo "<tr>" >> $INDEXFILE
    if [ -z "$TYPE" ]; then
	if [ "$ZONE" = "$HOSTNAME" ]; then
    	echo "<td><font size=2><b>ZONE</b></font></td>" >> $INDEXFILE
	else
	echo "<td bgcolor="#d5d8dc"><font size=2><b>LDOM</b></font></td>" >> $INDEXFILE
	fi
    else
    echo "<td bgcolor="#ffffb3"><font size=2><b>PDOM</b></font></td>" >> $INDEXFILE
    fi
    echo "<td><font size=3>$HOSTNAME</font></td>" >> $INDEXFILE
    if [ -z "$IP" ]; then
    echo "<td>N/A</td>" >> $INDEXFILE
    else
    echo "<td>$IP</td>" >> $INDEXFILE
    fi
    if [ -z "$IPBKP" ]; then
    echo "<td>N/A</td>" >> $INDEXFILE
    else
    echo "<td>$IPBKP</td>" >> $INDEXFILE
    fi
    if [ -z "$SO" ]; then
    echo "<td>Solaris</td>" >> $INDEXFILE
    else
    echo "<td>$SO</td>" >> $INDEXFILE
    fi
    if [ -z $RELEASE ]; then
    echo "<td>N/A</td>" >> $INDEXFILE
    else
    echo "<td>$RELEASE</td>" >> $INDEXFILE
    fi
    if [ -z "$UPTIME" ]; then
    echo "<td>N/A</td>" >> $INDEXFILE
    else
    echo "<td>$UPTIME</td>" >> $INDEXFILE
    fi

    if [ -z "$APP" ]; then
    echo "<td><font size=2>Not Identified</font></td>" >> $INDEXFILE
    else
    echo "<td><font size=2>$APP</font></td>" >> $INDEXFILE
    fi

    if [ -z "$TYPE" ]; then
	if [ "$ZONE" = "$HOSTNAME" ]; then
 	echo "<td><a target="_blank" href="inventory/$HTML">$HOSTNAME</a></td>" >> $INDEXFILE
  	else
    	echo "<td bgcolor="#d5d8dc"><a target="_blank" href="inventory/$HTML">$HOSTNAME</a></td>" >> $INDEXFILE
    	fi
    else
    echo "<td bgcolor="#ffffb3"><a target="_blank" href="inventory/$HTML">$HOSTNAME</a></td>" >> $INDEXFILE
    fi

    echo "<td><font size=2>$DATE</font></td>" >> $INDEXFILE
echo "</tr>" >> $INDEXFILE

done
done

echo "</center></table>" >> $INDEXFILE
echo "<p>" >> $INDEXFILE
echo "<a target="_blank" href="backup.html">OLD Inventory Files</a>" >> $INDEXFILE
echo "<p>" >> $INDEXFILE

TOTAL=`ls /var/www/html/inventory/*_cfg.html | wc -l`

echo "<center><table border=1>" >> $INDEXFILE
echo "<tr>" >> $INDEXFILE
echo "<th>Total Servers:</th>" >> $INDEXFILE
echo "<td><b>$TOTAL</b></td>" >> $INDEXFILE
echo "<tr>" >> $INDEXFILE
echo "</center></table>" >> $INDEXFILE

echo "<p>" >> $INDEXFILE
echo "<center>Index Updated at `date`.</center>" >> $INDEXFILE
echo "<p>" >> $INDEXFILE
echo "<center>Index updated each 15 minutes.</center>" >> $INDEXFILE
echo "<center><img src="ibm.JPG"></center>" >> $INDEXFILE

echo "</html>" >> $INDEXFILE

####################################################################################

# INDEX BACKUP HTML 

echo "<html>" > $INDEX_BKP

echo "<head>" >> $INDEX_BKP
echo "<title>Inventory Banorte Backup - Solaris Environment</title>" >> $INDEX_BKP
echo "<center><img src="banorte.JPG"></center>" >> $INDEX_BKP
echo "</head>" >> $INDEX_BKP
echo "<p>" >> $INDEX_BKP
echo "<center><h2>Solaris Banorte Backup Inventory - M5000</h2></center>" >> $INDEX_BKP
echo "<p>" >> $INDEX_BKP


echo "<center><table border=1>" >> $INDEX_BKP
  echo "<tr>" >> $INDEX_BKP
    echo "<th>File</th>" >> $INDEX_BKP
  echo "</tr>" >> $INDEX_BKP

for i in `ls /var/www/html/inventory/backup/*.html | grep -v consola`; do

HTML=`echo $i | gawk -F/ '{ print $7 }'`

echo "<tr>" >> $INDEX_BKP
    echo "<td><a target="_blank" href="inventory/backup/$HTML">$HTML</a></td>" >> $INDEX_BKP
echo "<tr>" >> $INDEX_BKP

done

echo "</center></table>" >> $INDEX_BKP

echo "<p>" >> $INDEX_BKP
echo "<center>Index Updated at `date`.</center>" >> $INDEX_BKP
echo "<p>" >> $INDEX_BKP
echo "<center>List udated each 15 minutes.</center>" >> $INDEX_BKP
echo "<center><img src="ibm.JPG"></center>" >> $INDEX_BKP

echo "</html>" >> $INDEX_BKP


echo "</html>" >> $INDEX_BKP

