FROM asciidoctor/docker-asciidoctor

 # Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Kalemena Asciidoctor" \
      org.label-schema.description="Kalemena Asciidoctor" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/docker-asciidoc" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ADD [ "pom.xml", "*.sh", "/opt/asciidoc/" ]

ENV JAVA_HOME=/usr/lib/jvm/default-jvm

RUN apk update ;\
    apk add --no-cache openjdk8 ;\
    ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/" ;\
    apk add maven graphviz git

RUN cd /opt ;\
    git clone https://github.com/kalemena/confluence-publisher.git ;\
    cd /opt/confluence-publisher ;\
    mvn clean install -Dmaven.test.skip=true

WORKDIR /opt/asciidoc 

# pre-fetch artifacts
RUN mvn -e -X org.sahli.asciidoc.confluence.publisher:asciidoc-confluence-publisher-maven-plugin:publish || true

CMD [ "bash", "/opt/asciidoc/build.sh" ]