FROM java:8

ENV VERSION=3.0.14

RUN apt-get update && apt-get install -y wget unzip
RUN addgroup --gid 1001 minecraft
RUN adduser --disabled-password --home=/data --uid 1001 --gid 1001 minecraft

RUN mkdir /tmp/ftb && cd /tmp/ftb && \
    wget -c https://addons-origin.cursecdn.com/files/2466/360/FTBPresentsSkyfactory3Server_${VERSION}.zip -O server.zip && \
    unzip server.zip && \
    rm server.zip && \
    bash -x FTBInstall.sh && \
    chown -R minecraft:minecraft /tmp/ftb

USER minecraft

EXPOSE 25565

ADD start.sh /start.sh

VOLUME /data
ADD server.properties /tmp/server.properties
WORKDIR /data

CMD /start.sh

ENV MOTD Skyfactory ${VERSION} - RageTroops
ENV LEVEL world
ENV JVM_OPTS -Xms2048m -Xmx2048m
