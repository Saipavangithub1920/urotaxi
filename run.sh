#!/bin/bash
${TOMCAT_HOME}/bin/startup.sh
tail -f /dev/null     # Dis-advantage -  your TTY will block. which means You can't tryp anything in terminal. to avoid this we need to run your container in forgroud process.
