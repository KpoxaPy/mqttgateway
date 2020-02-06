FROM alpine:latest 

EXPOSE 9337

COPY bin/mqttgateway /mqttgateway
ENTRYPOINT ["/mqttgateway"]
