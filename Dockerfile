ARG NEO4J_VERSION=4.4.21-community

FROM alpine:3.17 as builder
ARG GDS_VERSION=2.3.4
RUN mkdir /app
WORKDIR /app
RUN wget -O gds.zip https://graphdatascience.ninja/neo4j-graph-data-science-${GDS_VERSION}.zip
RUN unzip gds.zip && rm -rf gds.zip


##############################################################################################


FROM neo4j:${NEO4J_VERSION} as prod

# copy plugins into the Docker image
COPY --from=builder /app/ /var/lib/neo4j/plugins

# install the apoc core plugin that is shipped with Neo4j
RUN cp /var/lib/neo4j/labs/apoc-* /var/lib/neo4j/plugins
