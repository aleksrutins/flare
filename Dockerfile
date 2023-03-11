FROM haskell:slim

RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
RUN gunzip elm.gz
RUN chmod +x elm
RUN mv elm /usr/bin/

RUN curl -fsSL https://esbuild.github.io/dl/latest | sh
RUN chmod +x esbuild
RUN mv esbuild /usr/bin/

ADD . /app

WORKDIR /app

RUN stack setup

RUN stack build

CMD ["stack", "exec", "flare"]