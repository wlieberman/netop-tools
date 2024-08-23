#!/bin/bash
cat /root/.ngc/config|grep apikey|cut -d' ' -f3
