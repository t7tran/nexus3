FROM sonatype/nexus3:3.6.2

USER root

ENV TZ=Australia/Melbourne

COPY entrypoint.sh /

RUN yum update -y && yum upgrade -y && yum install tzdata && \
    chmod +x /entrypoint.sh && \
    yum clean all && rm -rf /var/cache/yum

ENTRYPOINT ["/entrypoint.sh"]
CMD ["su", "-m", "-s", "/bin/bash", "-c", "${SONATYPE_DIR}/start-nexus-repository-manager.sh", "nexus"]
