FROM alpine:latest
USER root
RUN apk --no-cache add rsync
CMD ["sleep","infinity"]
