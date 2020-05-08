FROM        moul/actions-base:v1.1.0
COPY        entrypoint.sh /entrypoint.sh
ENTRYPOINT  ["/entrypoint.sh"]
