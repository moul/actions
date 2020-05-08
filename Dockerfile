FROM        moul/actions-base:v1.1.0
RUN         apk add --no-cache jq curl
COPY        entrypoint.sh /entrypoint.sh
ENTRYPOINT  ["/entrypoint.sh"]
