# syntax=docker/dockerfile:1

ARG GO_VERSION=1.18
ARG GORELEASER_XX_VERSION=1.5.0

FROM --platform=$BUILDPLATFORM crazymax/goreleaser-xx:${GORELEASER_XX_VERSION} AS goreleaser-xx
FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS base
ENV CGO_ENABLED=0
COPY --from=goreleaser-xx / /
RUN apk add --no-cache ca-certificates file git
WORKDIR /src

FROM base AS vendored
RUN --mount=type=bind,target=/src,rw \
  --mount=type=cache,target=/go/pkg/mod \
  go mod tidy && go mod download

FROM vendored AS build
# GIT_REF is used by goreleaser-xx to handle the proper git ref when available.
# It will fallback to the working tree info if empty and use "git tag --points-at"
# or "git describe" to define the version info.
ARG GIT_REF
ARG TARGETPLATFORM
ARG PKG="github.com/anchore/syft"
RUN --mount=type=bind,target=. \
  --mount=type=cache,target=/root/.cache/go-build \
  --mount=type=cache,target=/go/pkg/mod \
  goreleaser-xx --debug \
    --name="syft" \
    --dist="/out" \
    --flags="-v" \
    --ldflags="-s -w -X '${PKG}/version.version={{.Version}}' -X '${PKG}/version.gitCommit={{.Commit}}' -X '${PKG}/version.buildDate={{.Date}}' -X '${PKG}/version.gitDescription={{.Summary}}'" \
    --files="LICENSE" \
    --files="README.md"

FROM scratch AS artifact
COPY --from=build /out/*.tar.gz /
COPY --from=build /out/*.zip /
COPY --from=build /out/*.sha256 /

FROM scratch AS binary
COPY --from=build /usr/local/bin/syft* /

FROM scratch
COPY --from=build /usr/local/bin/syft /syft
# needed for version check HTTPS request
COPY --from=base /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# create the /tmp dir, which is needed for image content cache
WORKDIR /tmp

ENTRYPOINT ["/syft"]
