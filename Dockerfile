FROM alpine:latest 

COPY bin/mqttgateway /mqttgateway
ENTRYPOINT ["/mqttgateway"]
