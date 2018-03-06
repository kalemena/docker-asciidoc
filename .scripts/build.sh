#!/bin/bash

function f 
{ 
    echo $1;
    dest="${1/documents/documents-rendered}"

    if [ -f "$1/readme.adoc" ]; then
        asciidoctor -a toc -a toc=left -a docinfo=shared -a data-uri -a icons -r asciidoctor-diagram -D /$dest/ -B /documents $1/readme.adoc
        asciidoctor-pdf -a icons -r asciidoctor-diagram -D /$dest/ -B /documents $1/readme.adoc
        # does not work well !!!
        # asciidoctor-confluence --host http://confluence:8090 --update --spaceKey ${CONFLUENCE_SPACEKEY} --title ${CONFLUENCE_TITLE} --username ${CONFLUENCE_USERNAME} --password ${CONFLUENCE_PASSWORD} /documents/demo1.adoc
    fi

    for i in $1/*; do 
        if [ -d "$i" ]; then 
            if [[ ! "$i" =~ ".build" ]] && [[ ! "$i" =~ ".scripts" ]] ; then               
                f $i;
            fi; 
        fi; 
    done 
}

# copy all
cp -r /documents/* /documents-rendered

# then process HTML and PDF
f /documents

# then process publish to confluence
mvn -e -X org.sahli.asciidoc.confluence.publisher:asciidoc-confluence-publisher-maven-plugin:publish
