HTTP Redirector Docker Image
==================================================

This is a simple docker image to handle domain redirects.

---

- [View on DockerHub][1]
- [View on Github][2]

---


Usage
--------------------------------------------------

### Configure Redirects

Use `REDIRECT*` environment variables to configure redirects. The value 
of each such variable should be in the syntax of `domain==target`. 

For example:

```
REDIRECT1=example.com==https://www.google.com
```

By default, the redirect is a Temporary Redirect (302). To use a Permanent 
Redirect (301), prefix the target with an exclamation mark:

```
REDIRECT1=example.com==!https://www.google.com
```


### Run the Server

```
$ REDIRECT1=example.com==https://www.google.com \
  REDIRECT2=another.com==https://github.com \
  docker run --rm -it -p 3000:3000 dannyben/redirector
```

### Docker Compose

```yaml
version: '3'

services:
  web:
    image: dannyben/redirector
    ports: ["3000:3000"]
    environment:
      REDIRECT1: 1.local==!https://www.google.com
      REDIRECT2: 2.local==https://github.com
```


---

[1]: https://hub.docker.com/r/dannyben/redirector/
[2]: https://github.com/DannyBen/docker-redirector

