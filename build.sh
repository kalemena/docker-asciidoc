#!/bin/bash

function f 
{ 
    echo $1;
    dest="${1/documents/documents-rendered}"
    asciidoctor -a toc -a data-uri -a icons -D /$dest/ -B /documents $1/*.adoc
    asciidoctor-pdf -a icons -D /$dest/ -B /documents $1/*.adoc
    # asciidoctor-confluence --host http://confluence:8090 --update --spaceKey ${CONFLUENCE_SPACEKEY} --title ${CONFLUENCE_TITLE} --username ${CONFLUENCE_USERNAME} --password ${CONFLUENCE_PASSWORD} /documents/demo1.adoc

    for i in $1/*; do 
        if [ -d $i ]; then 
            if [[ ! "$i" =~ "images" ]] && [[ ! "$i" =~ "includes" ]]; then               
                f $i;
            fi; 
        fi; 
    done 
}

f /documents