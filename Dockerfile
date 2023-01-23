FROM postgres:15.1-alpine

WORKDIR /greenlight

COPY . .

RUN go build