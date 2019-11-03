FROM ubuntu:bionic
MAINTAINER Laszlo Budai <laszlo.budai@outlook.com>

RUN apt-get update
RUN apt-get install -y default-jre-headless \
                       pdsh \
                       ssh \
                       wget \
                       vim

RUN mkdir hadoop && cd hadoop && wget https://www-eu.apache.org/dist/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz && tar xzf hadoop-3.1.3.tar.gz; rm hadoop-3.1.3.tar.gz
COPY hdfs-site.xml /hadoop/hadoop-3.1.3/etc/hadoop/
COPY core-site.xml /hadoop/hadoop-3.1.3/etc/hadoop
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 0600 ~/.ssh/authorized_keys
RUN echo "JAVA_HOME=/usr/lib/jvm/default-java" >> /hadoop/hadoop-3.1.3/etc/hadoop/hadoop-env.sh
RUN /hadoop/hadoop-3.1.3/bin/hdfs namenode -format
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 50010 50020 50070 50075 50090 8020 9000

