# syntax=docker/dockerfile:1.4
FROM docker.io/cricketeerone/apache-kafka-connect:3.4.0-confluent-hub@sha256:90d5e0a449ec73ebd0def24dcb3f5bb18e446e137b9a2d8e7f9aff3f9f7168cd

WORKDIR /tmp

RUN <<EOF
confluent-hub install --no-prompt \
    --component-dir /app/libs --worker-configs /app/resources/connect-distributed.properties -- \
    confluentinc/kafka-connect-jdbc:10.7.2

curl -LSs https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-j-8.0.33.tar.gz | tar xz
mv mysql-connector-j-8.0.33/mysql-connector-j-8.0.33.jar /app/libs/confluentinc-kafka-connect-jdbc/
rm -rf mysql-connector-j-8.0.33/
EOF

WORKDIR /
USER 65532:65532
