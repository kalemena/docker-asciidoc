FROM asciidoctor/docker-asciidoctor

ADD [ "pom.xml", "*.sh", "/opt/asciidoc/" ]

WORKDIR /opt/asciidoc 

ENV JAVA_HOME=/usr/lib/jvm/default-jvm

RUN apk update ;\
    apk add --no-cache openjdk8 ;\
    ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/" ;\
    apk add maven graphviz

# pre-fetch artifacts
RUN mvn -e -X org.sahli.asciidoc.confluence.publisher:asciidoc-confluence-publisher-maven-plugin:publish || true

CMD [ "bash", "/opt/asciidoc/build.sh" ]