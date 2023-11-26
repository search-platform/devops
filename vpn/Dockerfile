FROM alpine:latest

RUN apk add --no-cache wireguard-tools iptables

COPY ./wg-config.conf /etc/wireguard/

COPY ./connect-vpn.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/connect-vpn.sh

CMD ["connect-vpn.sh"]
