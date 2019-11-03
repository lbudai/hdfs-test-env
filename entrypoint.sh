#!/bin/bash -e

export JAVA_HOME=/usr/lib/jvm/default-java

export HDFS_NAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export HDFS_SECONDARYNAMENODE_USER="root"

export PDSH_RCMD_TYPE=ssh

service ssh start

IP_ADDR="$(grep $(hostname) /etc/hosts | awk '{print $1}')"
sed -i "s/localhost/${IP_ADDR}/g" /hadoop/hadoop-3.1.3/etc/hadoop/core-site.xml

/hadoop/hadoop-3.1.3/bin/hdfs --workers --daemon start namenode
/hadoop/hadoop-3.1.3/bin/hdfs --workers --daemon start datanode

/hadoop/hadoop-3.1.3/bin/hdfs dfs -mkdir -p /syslog-ng
/hadoop/hadoop-3.1.3/bin/hdfs dfs -chmod 777 /syslog-ng

exec "$@"

