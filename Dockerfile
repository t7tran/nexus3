FROM sonatype/nexus3:3.26.1

USER root

#ENV TZ=Australia/Melbourne

COPY entrypoint.sh /

RUN yum update -y && yum upgrade -y && yum install -y tzdata && \
    # install gosu
    curl -fsSL "https://github.com/tianon/gosu/releases/download/1.12/gosu-amd64" -o /usr/bin/gosu && \
    chmod +x /usr/bin/gosu && \
    gosu nobody true && \
    # complete gosu
    chmod +x /entrypoint.sh && \
    yum clean all && rm -rf /var/cache/yum

ENTRYPOINT ["/entrypoint.sh"]
CMD ["gosu", "nexus", "/opt/sonatype/start-nexus-repository-manager.sh"]
