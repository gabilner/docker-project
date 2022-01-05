from alpine:3.15.0

apk update
apk add --no-cache python3 py3-pip
RUN apk add git

