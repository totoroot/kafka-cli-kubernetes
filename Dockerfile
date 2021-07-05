FROM ringcentral/jdk:11

MAINTAINER Matthias Thym <git@thym.at>

ENV KAFKA_VERSION=2.8.0
ENV KAFKA_URL=https://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.13-${KAFKA_VERSION}.tgz
ENV KAFKA_TMP_DEST=/opt/kafka.tgz
ENV KAFKA_WORKDIR=/opt/kafka

ADD run.sh /opt/run.sh

RUN chmod +x /opt/run.sh && \
    wget $KAFKA_URL -O ${KAFKA_TMP_DEST} && \
    mkdir -p ${KAFKA_WORKDIR} && \
    tar -xvzpf ${KAFKA_TMP_DEST} --strip-components=1 -C ${KAFKA_WORKDIR} && \
    rm ${KAFKA_TMP_DEST} && \
    rm -rf ${KAFKA_WORKDIR}/bin/windows

ENV PATH ${PATH}:/opt/kafka/bin

WORKDIR [ "/opt" ]
ENTRYPOINT [ "/opt/run.sh" ]
