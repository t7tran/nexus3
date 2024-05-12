FROM sonatype/nexus3:3.68.0

USER root

RUN microdnf update -y && microdnf install --setopt=install_weak_deps=0 --setopt=tsflags=nodocs -y tzdata && \
    # install gosu
    curl -fsSL "https://github.com/tianon/gosu/releases/download/1.17/gosu-amd64" -o /usr/bin/gosu && \
    chmod +x /usr/bin/gosu && \
    gosu nobody true && \
    # complete gosu
    microdnf clean all && rm -rf /var/cache/yum

USER nexus

ENTRYPOINT ["/opt/sonatype/nexus/bin/nexus"]
CMD ["run"]
