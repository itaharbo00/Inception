#!/bin/bash
set -e

# Load the conf
source /etc/cadvisor/cadvisor.conf

echo "[INIT] Starting cAdvisor on port ${PORT} ..."
exec /usr/bin/cadvisor \
    --port=${PORT} \
    --logtostderr=${LOGTOSTDERR}
