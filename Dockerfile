#
FROM elixir

#
RUN mix local.hex --force

#
RUN mkdir /fiesp

#
WORKDIR /fiesp

#
ADD . .
