FROM elixir:1.8.0
EXPOSE 4000
WORKDIR /app
RUN mix local.hex --force && mix local.rebar --force
COPY . /app/
ENV MIX_ENV=prod
ENV PORT=4001
RUN mix deps.get
RUN mix deps.compile
RUN mix compile
RUN mix phx.digest

RUN curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
RUN chmod a+rx /usr/local/bin/youtube-dl

CMD ["mix", "phx.server", "--no-halt", "--no-compile", "--no-deps-check"]
