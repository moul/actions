FROM        moul/actions-base:v1.1.1
COPY        entrypoint.sh /entrypoint.sh
ENTRYPOINT  ["/entrypoint.sh"]
