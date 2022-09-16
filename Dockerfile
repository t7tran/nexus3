FROM sonatype/nexus3:3.41.1

USER root

#ENV TZ=Australia/Melbourne

COPY entrypoint.sh /

RUN microdnf update -y && microdnf install --setopt=install_weak_deps=0 --setopt=tsflags=nodocs -y tzdata && \
    # install gosu
    curl -fsSL "https://github.com/tianon/gosu/releases/download/1.14/gosu-amd64" -o /usr/bin/gosu && \
    chmod +x /usr/bin/gosu && \
    gosu nobody true && \
    # complete gosu
    chmod +x /entrypoint.sh && \
    microdnf clean all && rm -rf /var/cache/yum

ENTRYPOINT ["/entrypoint.sh"]
CMD ["gosu", "nexus", "/opt/sonatype/start-nexus-repository-manager.sh"]
