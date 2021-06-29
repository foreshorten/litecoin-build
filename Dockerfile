FROM golang

ENV LITECOIN_ASCLINK https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-linux-signatures.asc
ENV LITECOIN_TARLINK https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-x86_64-linux-gnu.tar.gz

RUN curl -sO $LITECOIN_TARLINK  && \
    LITECOIN_ASC=$(curl -s $LITECOIN_ASCLINK | awk '/x86/ {print $1}') && \
    echo "$LITECOIN_ASC litecoin-0.18.1-x86_64-linux-gnu.tar.gz" | sha256sum --check --status && \
    tar -xzvf litecoin-0.18.1-x86_64-linux-gnu.tar.gz && \
    cp litecoin-0.18.1/bin/litecoind /usr/local/bin/

RUN useradd -m litecoin

USER litecoin
WORKDIR /home/litecoin


CMD [ "litecoind" ]