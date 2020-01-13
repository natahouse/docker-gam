FROM alpine:latest

ENV PATH="/opt/bin:$PATH" \
    SOURCE_URL="https://github.com/jay0lee/GAM.git"

ADD .bashrc /root/.bashrc

RUN apk add --update --no-cache bash curl git python py-crypto py-openssl py-pip \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/bin \
    && git clone --depth 1 -b master ${SOURCE_URL} /opt/gam \
    && ln -s /opt/gam/src/gam.py /opt/bin/gam \
    && touch /opt/gam/src/nobrowser.txt \
    && touch /opt/gam/src/noupdatecheck.txt

RUN pip3 --disable-pip-version-check install -r /opt/gam/src/requirements.txt

WORKDIR /root
ENTRYPOINT ["gam"]
