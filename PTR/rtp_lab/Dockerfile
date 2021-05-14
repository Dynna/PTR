FROM elixir

WORKDIR /rtp_lab

COPY . .

RUN mix local.hex --force
RUN mix deps.get
