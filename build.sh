#!/bin/bash

function f 
{ 
    echo $1;
    dest="${1/documents/documents-rendered}"
    asciidoctor -a toc -a data-uri -a icons -D /$dest/ $1/*.adoc
    asciidoctor-pdf -a icons -D /$dest/ $1/*.adoc

    for i in $1/*; do 
        if [ -d $i ]; then 
            # echo $i; 
            f $i; 
        fi; 
    done 
}

f /documents