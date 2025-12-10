FROM python:3.12-slim

RUN pip install --no-cache-dir \
    robotframework \
    robotframework-sshlibrary

WORKDIR /opt/robot

CMD ["bash", "-lc", "mkdir -p /opt/robot/results && cd /opt/robot/results && python3 -m http.server 8080"]
