#!/usr/bin/env bash

set -x

unset HISTFILE
/sbin/service rsyslog stop
/sbin/service auditd stop

/usr/bin/yum erase -y iwl*

if [ -x /bin/package-cleanup ]; then
	/bin/package-cleanup -y --oldkernels --count=1
fi
if [ -x /bin/dnf ]; then
	/bin/dnf -y remove --oldinstallonly --setopt installonly_limit=1
fi

/usr/bin/subscription-manager unregister
/usr/bin/subscription-manager clean
/bin/rm -f /etc/rhsm/facts/katello.facts
/bin/rm -f /var/cache/katello-agent/enabled_repos.json
/usr/bin/yum clean all
/bin/rm -rf /var/cache/yum
/bin/rm -rf /var/cache/dnf
/bin/rm -rf /etc/puppetlabs/puppet/ssl/
/bin/rm -f /opt/puppetlabs/puppet/cache/client_data/catalog/*.json
/bin/rm -rf /opt/puppetlabs/puppet/cache/clientbucket/*
/bin/rm -f /var/lib/samba/private/secrets.tdb

if [ -f /etc/krb5.keytab ]; then
	echo -e "\0005\0002\c" > /etc/krb5.keytab
fi

if [ -x /usr/sbin/sss_cache ]; then
	/usr/sbin/sss_cache -E
fi
/bin/rm -rf /var/lib/sss/db/{cache_*,timestamps_*}

if [ -d /var/db/sudo/lectured ]; then
	/bin/rm -f /var/db/sudo/lectured/*
fi

/usr/sbin/logrotate -f /etc/logrotate.conf || /bin/true

if [ -f /var/log/audit/audit.log ]; then
	/bin/cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/messages ]; then
	/bin/cat /dev/null > /var/log/messages
fi
if [ -f /var/log/wtmp ]; then
	/bin/cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
	/bin/cat /dev/null > /var/log/lastlog
fi
if [ -f /var/log/grubby ]; then
	/bin/cat /dev/null > /var/log/grubby
fi

/bin/rm -f /var/log/audit/audit.log.*
/bin/rm -f /var/log/messages-*
/bin/rm -f /var/log/maillog-*
/bin/rm -f /var/log/cron-*
/bin/rm -f /var/log/spooler-*
/bin/rm -f /var/log/secure-*
/bin/rm -f /var/log/yum-*
/bin/rm -f /var/log/up2date-*
/bin/rm -f /var/log/dmesg.old
/bin/rm -f /var/log/*-????????
/bin/rm -f /var/log/*.gz
/bin/rm -rf /var/log/anaconda
/bin/rm -rf /root/.ssh
/bin/rm -f /root/anaconda-ks.cfg
/bin/rm -f /root/original-ks.cfg
/bin/rm -f /root/.bash_history

/bin/sed -i '/^[ \t]*\(HWADDR\|UUID\)/d' /etc/sysconfig/network-scripts/ifcfg-e*
/bin/rm -f /etc/udev/rules.d/70-persistent-net.rules
/bin/rm -f /etc/dhcp/dhclient-exit-hooks
/bin/rm -f /etc/machine-id

echo "localhost" > /etc/hostname
echo "127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4" > /etc/hosts
echo "::1       localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts

/bin/rm -f /etc/ssh/ssh_host_*
/bin/rm -rf /tmp/*
/bin/rm -rf /var/tmp/*
