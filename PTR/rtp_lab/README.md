# RtpLab

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `rtp_lab` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:rtp_lab, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/rtp_lab](https://hexdocs.pm/rtp_lab).

What has been done

- read 2 SSE streams of actual Twitter API tweets in JSON format
- to read SSE this project was used: https://github.com/cwc/eventsource_ex
- built entities: connection, router, supervisor, worker
- sent messages to worker using dynamic supervisor
- parsed the message & extracted text sequence
- calculated the sentiment score for each text sequence in a message

Results

![alt text](gif/new_gif_rtp.gif)

