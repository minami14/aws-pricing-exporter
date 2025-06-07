FROM golang:1.24.4 AS builder

WORKDIR /src

RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,source=go.mod,target=go.mod \
    --mount=type=bind,source=go.sum,target=go.sum \
    go mod download -x

RUN --mount=type=cache,target=/go/pkg/mod/ \
    --mount=type=bind,source=.,target=. \
    CGO_ENABLED=0 go build -o /bin/aws-pricing-exporter .

FROM gcr.io/distroless/static-debian12:latest

COPY --chown=nonroot:nonroot --from=builder /bin/aws-pricing-exporter /bin/

USER nonroot

ENTRYPOINT [ "/bin/aws-pricing-exporter" ]

EXPOSE 8080
