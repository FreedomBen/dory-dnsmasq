ARG alpine_tag

FROM alpine:${alpine_tag}

ARG dnsmasq_version
RUN apk --no-cache add dnsmasq-dnssec=${dnsmasq_version}
EXPOSE 53 53/udp

COPY dnsmasq.conf /etc/dnsmasq.conf
COPY start-with-domain-ip.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start-with-domain-ip.sh

ENTRYPOINT ["/usr/local/bin/start-with-domain-ip.sh"]
CMD ["docker", "127.0.0.1"]
