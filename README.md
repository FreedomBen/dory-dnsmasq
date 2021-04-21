# Dory's dnsmasq container

## What is this?

[Dory](https://github.com/FreedomBen/dory) uses this container to provide the dnsmasq
services in conjunction with an nginx-proxy. It's a very lightweight container built
on Alpine Linux (based off of [andyshinn/dnsmasq](https://hub.docker.com/r/andyshinn/dnsmasq/).
See the [dory](https://github.com/FreedomBen/dory) project page for more info.

## How do I use it?

### A single TLD

You can use this container in your project, or as a standalone utility if you'd like.

Here's how to fire it up.

```
docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN freedomben/dory-dnsmasq:1.0.0 [<domain>] [<ip>]
```

So if you wanted all queries against domain "docker" to be routed to IP 3.3.3.3:

```
docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN freedomben/dory-dnsmasq:1.0.0 docker 3.3.3.3
```

If you'd rather extend it to bake in your defaults, here's an example:

```
FROM freedomben/dory-dnsmasq

CMD["docker", "3.3.3.3"]
```

### Multiple TLDs

You can have more than one TLD if you prefer. Use the container the same way as with a single TLD, but add each domain and ip as extra args.

```
docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN freedomben/dory-dnsmasq:1.0.0 [<domain1>] [<ip1>] [<domain2>] [<ip2>]
```

So if you wanted all queries against domain "docker" to be routed to IP 3.3.3.3, and dev to be routed to 4.4.4.4:

```
docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN freedomben/dory-dnsmasq:1.0.0 docker 3.3.3.3 dev 4.4.4.4
```

The domains can go to the same IP. You just have to repeat it. Say you wanted both to go to 3.3.3.3:

```
docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN freedomben/dory-dnsmasq:1.0.0 docker 3.3.3.3 dev 3.3.3.3
```

### Wildcard

You can have all domain names that are not answered from /etc/hosts or DHCP be resolved to a specific address by using a `#` as the domain. So to have all requests be resolved to 4.4.4.4:

```
docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN freedomben/dory-dnsmasq:1.0.0 '#' 4.4.4.4
```

_NOTE: You have to put the # in quotes otherwise bash will think it's a comment character_

### Build and push images

Create the builder:

```bash
make builder
```

Build and push images:

```bash
make build push
```
