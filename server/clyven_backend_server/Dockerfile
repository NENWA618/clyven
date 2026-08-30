# Build from the Clyven monorepo root with:
# docker build -f server/clyven_backend_server/Dockerfile .

FROM dart:3.12.2 AS build

WORKDIR /app

# Preserve the workspace dependency lock.
COPY pubspec.lock .

# Copy the Serverpod server package.
COPY server/clyven_backend_server server/clyven_backend_server

# Create a minimal Docker build workspace containing only the server.
RUN printf '%s\n' \
  'name: clyven_docker_workspace' \
  'publish_to: none' \
  'environment:' \
  '  sdk: ^3.12.2' \
  'workspace:' \
  '  - server/clyven_backend_server' \
  > pubspec.yaml

RUN dart pub get

# Compile Serverpod.
WORKDIR /app/server/clyven_backend_server
RUN dart compile exe bin/main.dart -o bin/server

RUN mkdir -p config web migrations


FROM alpine:latest

WORKDIR /app

ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

COPY --from=build /runtime/ /

COPY --from=build /app/server/clyven_backend_server/bin/server server

COPY --from=build /app/server/clyven_backend_server/config/ config/
COPY --from=build /app/server/clyven_backend_server/web/ web/
COPY --from=build /app/server/clyven_backend_server/migrations/ migrations/

COPY --from=build /app/server/clyven_backend_server/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role
