FROM elixir

WORKDIR /rtp_lab

COPY . .

RUN mix local.hex --force
RUN mix deps.get

CMD mix run --no-halt
