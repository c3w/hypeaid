#!/bin/bash

###
## hypeaid.sh
## rev 2012JAN6 c3w@juicypop.net
## replace hype js (app store: hype) %%FIELD%% with field.inc contents
## e.g. in your hype document, add some text reading %%CONTENT%% and then create
## a content.inc file with some html (currently " is not supported.. use ' for hyperlinks etc)
## 
## more bugfixes and documentation coming soon

if [ ! "${1}" ]; then { echo "Usage: hypeaid.sh [PROJECT]"; exit 1; }; fi
PROJECT=~/Documents/${1}_Resources/${1}_hype_generated_script.js

if [ ! -f ${PROJECT} ]; then { echo "${PROJECT} not found.  exiting."; exit 1; }; fi

echo "Using Project ${PROJECT}"

TEMPFILE=$(mktemp -t hypeaid)

for file in *\.inc; do {
	regex="%%$(echo ${file%%\.inc}|tr [:lower:] [:upper:])%%"
	cat ${PROJECT}|sed -e "s^${regex}^$(cat ${file}|tr '\n' ' ')^g" > ${TEMPFILE}
	cp ${TEMPFILE} ${PROJECT}
}; done
