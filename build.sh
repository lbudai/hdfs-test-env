#!/bin/sh -e

docker build --force-rm --tag syslog-ng-hadoop --file Dockerfile .

