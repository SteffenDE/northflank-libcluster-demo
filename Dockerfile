# Build stage
FROM elixir:1.19.3-alpine AS builder

# Set environment variables
ENV MIX_ENV=prod

WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock* ./
RUN mix deps.get --only prod
RUN mix deps.compile

COPY lib lib
COPY config config
COPY rel rel

RUN mix release

# Runner stage
FROM alpine:3.22

RUN apk add --no-cache libstdc++ ncurses-libs openssl

WORKDIR /app

COPY --from=builder /app/_build/prod/rel/libcluster_example ./

EXPOSE 4369

# Start the application
CMD ["bin/libcluster_example", "start"]
