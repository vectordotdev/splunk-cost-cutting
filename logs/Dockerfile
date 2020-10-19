FROM golang:1.15 AS builder

WORKDIR /home
COPY . ./
RUN go mod vendor
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /logs .

FROM scratch
COPY --from=builder /logs ./
ENTRYPOINT ["./logs"]
