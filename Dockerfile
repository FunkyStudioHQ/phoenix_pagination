FROM elixir:1.13.4

RUN apt-get update && \
    apt-get install -y postgresql-client inotify-tools

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force && mix local.rebar --force


CMD ["/app/entrypoint.sh"]
