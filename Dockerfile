FROM debian

ENV ZK_VER 3.8.0
ENV FILE apache-zookeeper-${ZK_VER}-bin.tar.gz
ENV ZK_DIR /zookeeper
ENV ZK_dataDir /var/lib/zookeeper
ENV ZK_timeTick 2000
ENV ZK_clientPort 2181

RUN apt update -y \
    && apt install openjdk-11-jdk gpg wget python3 -y

RUN wget https://dlcdn.apache.org/zookeeper/zookeeper-${ZK_VER}/${FILE} \
    && mkdir -p ${ZK_DIR} \
    && tar -xvzf ${FILE} -C ${ZK_DIR} \
    && mv ${ZK_DIR}/apache-zookeeper-${ZK_VER}-bin/* ${ZK_DIR} \
    && rm -rf ${ZK_DIR}/apache-zookeeper-${ZK_VER}-bin/ ${FILE}

ADD create_conf.py .
ADD entrypoint.sh .

RUN chmod +x create_conf.py entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
