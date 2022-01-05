from alpine:3.15.0

RUN apk update
RUN apk add --no-cache python3 py3-pip
RUN apk add git

RUN mkdir -p /home/git
